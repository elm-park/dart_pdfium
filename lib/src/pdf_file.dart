import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:dart_pdfium/src/helper.dart';

import '../pdfium.dart';

class PdfFile {
  Pointer<fpdf_document_t__> document;
  String filePath;
  PdfFile(this.document);
  Pdfium pdfium;

  PdfFile.fromFile(this.filePath) {
    pdfium = Pdfium();
    document = pdfium.lib
        .FPDF_LoadDocument(Utf8.toUtf8(filePath).cast<Int8>(), nullptr);
  }
  num get pageCounts => pdfium.lib.FPDF_GetPageCount(document);

  String getMetaText(String tag) {
    final buffer = allocate<Uint16>(count: MAX_META_LENGTH);
    final buflen = pdfium.lib.FPDF_GetMetaText(
        document, str2Int8(tag), buffer.cast<Void>(), MAX_META_LENGTH);
    if (buflen <= 2) return "";
    final str = String.fromCharCodes(
        buffer.cast<Uint16>().asTypedList(buflen ~/ 2 - 1));
    return str;
  }
}
