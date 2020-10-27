import 'dart:math';
import 'dart:ffi';

import 'package:dart_pdfium/pdfium.dart';
import 'package:dart_pdfium/src/pdf_text_span.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as imageUtil;
import '../ffi_gen/ffi_gen.dart';

class PdfPage {
  double width;
  double height;
  Pointer<fpdf_document_t__> document;
  Pointer<fpdf_page_t__> page;
  Pointer<fpdf_textpage_t__> textPage;
  int pageIndex;
  int charCount;
  Pdfium pdfium;

  PdfPage(this.document, this.pageIndex) {
    pdfium = Pdfium();
    page = pdfium.lib.FPDF_LoadPage(document, pageIndex);
    textPage = pdfium.lib.FPDFText_LoadPage(page);
    width = pdfium.lib.FPDF_GetPageWidthF(page);
    height = pdfium.lib.FPDF_GetPageHeightF(page);
    charCount = pdfium.lib.FPDFText_CountChars(textPage);
    //TODO: load form
  }

  String getPageText() {
    return getSpanText(PdfTextSpan(pageIndex, 0, charCount));
  }

  String getSpanText(PdfTextSpan span) {
    final result = allocate<Uint8>(count: (span.length + 1) * 2);
    final count = pdfium.lib.FPDFText_GetText(
        textPage, span.offset, span.length + 1, result.cast());
    if (count == 0) return "";
    return String.fromCharCodes(result.cast<Uint16>().asTypedList(count - 1));
  }

  int getCharIndexAtPos(Point point, {xTolerance = 4.0, yTolerance = 4.0}) {
    return pdfium.lib.FPDFText_GetCharIndexAtPos(
        textPage, point.x, point.y, xTolerance, yTolerance);
  }

  ///
  Point pageToDevice(Point point) {
    Pointer<Int32> dx;
    Pointer<Int32> dy;
    pdfium.lib.FPDF_PageToDevice(
        page, 0, 0, width.toInt(), height.toInt(), 0, point.x, point.y, dx, dy);
    return Point(dx.value, dy.value);
  }

  ///
  Point deviceToPage(Point point) {
    Pointer<Double> dx;
    Pointer<Double> dy;
    pdfium.lib.FPDF_DeviceToPage(
        page, 0, 0, width.toInt(), height.toInt(), 0, point.x, point.y, dx, dy);
    return Point(dx.value, dy.value);
  }

  ///
  Rectangle rectangleToPage(Rectangle rect) {
    Point point1 = deviceToPage(Point(rect.left, rect.top));
    Point point2 = deviceToPage(Point(rect.right, rect.bottom));
    return Rectangle.fromPoints(point1, point2);
  }

  /// convert a `Rectangle` from pdf page coordinates to device coordinates
  ///
  /// rect
  Rectangle pageToRectangle(Rectangle rect) {
    Point point1 = pageToDevice(Point(rect.left, rect.top));
    Point point2 = pageToDevice(Point(rect.right, rect.bottom));
    return Rectangle.fromPoints(point1, point2);
  }

  /// Render to bitmap
  ///
  ///
  Pointer<fpdf_bitmap_t__> renderBitmap(width, height) {
    // final width = (this.width * scale).toInt();
    // final height = (this.height * scale).toInt();
    final bitmap = pdfium.lib.FPDFBitmap_Create(width, height, 1);
    pdfium.lib.FPDFBitmap_FillRect(bitmap, 0, 0, width, height, 0xFFFFFFFF);
    pdfium.lib.FPDF_RenderPageBitmap(bitmap, page, 0, 0, width, height, 0, 0);
    return bitmap;
  }

  /// render to image
  imageUtil.Image renderImage({scale = 1.0}) {
    final width = (this.width * scale).toInt();
    final height = (this.height * scale).toInt();
    final bitmap = renderBitmap(width, height);
    final buffer = pdfium.lib
        .FPDFBitmap_GetBuffer(bitmap)
        .cast<Int32>()
        .asTypedList(width * height)
        .buffer
        .asInt8List();
    return imageUtil.Image.fromBytes(width, height, buffer,
        format: imageUtil.Format.bgra);
  }
}
