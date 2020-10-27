import 'dart:ffi';
import 'package:dart_pdfium/pdfium.dart';
import 'package:dart_pdfium/src/pdf_file.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart';
import 'dart:io';
import 'dart:typed_data';

String GetMetaText(NativeLibrary lib, Pointer<fpdf_document_t__> doc, String tag) {
  final tag_int8 = Utf8.toUtf8(tag).cast<Int8>();
  final buffer = allocate<Uint16>(count: MAX_META_LENGTH);
  final buflen = lib.FPDF_GetMetaText(
      doc, tag_int8, buffer.cast<Void>(), MAX_META_LENGTH
  );
  if (buflen <= 2) return "";
  final str = String.fromCharCodes(buffer.cast<Uint16>().asTypedList(buflen~/2-1));
  return str;
}

void main() {
  final pdfium = NativeLibrary(DynamicLibrary.open(PDFIUM_FILE));
  final lib = Pdfium().lib;
  //pdfium.FPDF_InitLibraryWithConfig(nullptr);
  // pdfiumLibraryInit();
  const pdfFile = '/Users/zhonghua/workspace/dart-space/dart_pdfium/test/demo2.pdf';

  final pdf = lib.FPDF_LoadDocument(Utf8.toUtf8(pdfFile).cast<Int8>(), nullptr);
  final page = lib.FPDF_LoadPage(pdf, 0);

  final pageCount = lib.FPDF_GetPageCount(pdf);
  print('Page Count: $pageCount');
  for(var tag in MetaTag.tagList) {
    final tagValue = GetMetaText(lib, pdf, tag);
    print('$tag: $tagValue');
  }

  // page = FPDF_LoadPage(pdf, 0);
  //
  // double width = FPDF_GetPageWidth(page);
  // double height = FPDF_GetPageHeight(page);
  // int pageCount = FPDF_GetPageCount(pdf);

  // print('pdf width: $width, height: $height, num of page: $pageCount');
  // print(FPDF_GetMetaText(pdf, Utf8.toUtf8("Author"), nullptr, 0));

  // double scale = 3.0;
  // int widthInt = (width * scale).toInt();
  // int heightInt = (height * scale).toInt();

  // Pointer<FPDF_BITMAP> bitmap = FPDFBitmap_Create(widthInt, heightInt, 0);
  // Pointer<FPDF_BITMAP> bitmap =
  //     FPDFBitmap_CreateEx(widthInt, heightInt, 4, Null, widthInt * 4);
  // FPDFBitmap_FillRect(bitmap, 0, 0, widthInt, heightInt, 0xFFFFFFFF);
  // FPDF_RenderPageBitmap(bitmap, page, 0, 0, widthInt, heightInt, 0, 0);
  // Uint8List buf = FPDFBitmap_GetBuffer(bitmap)
  //     .asTypedList(widthInt * heightInt)
  //     .buffer
  //     .asUint8List();
  // Image img = Image.fromBytes(widthInt, heightInt, buf);
  // File('./playground/page-1.png').writeAsBytesSync(encodePng(img));
  //encodePng(img);
}
