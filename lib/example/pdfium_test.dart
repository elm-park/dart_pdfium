import 'dart:io';
import 'package:dart_pdfium/src/pdf_file.dart';
import 'package:dart_pdfium/src/pdf_page.dart';
import 'package:image/image.dart';

main() {
  const filePath = 'test/demo2.pdf';
  const imgPath = 'test/page.png';
  final pdfFile = PdfFile.fromFile(filePath);
  final page = PdfPage(pdfFile.document, 1);
  print("PAGE COUNTS: ${pdfFile.pageCounts}");
  print("Meta: ${pdfFile.getMetaText('Title')}");
  print("Page 0 width: ${page.width}, height: ${page.height}");
  print("Page 0 text: ${page.getPageText()}");
  final image = page.renderImage(scale: 1.0);
  File(imgPath).writeAsBytesSync(encodePng(image));
}
