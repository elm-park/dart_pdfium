import 'dart:io';
import 'dart:math';
import 'package:dart_pdfium/src/pdf_file.dart';
import 'package:dart_pdfium/src/pdf_page.dart';
import 'package:dart_pdfium/src/pdf_text_span.dart';
import 'package:image/image.dart' as imageUtil;

main() {
  const filePath = 'test/demo2.pdf';
  const imgPath = 'test/page.png';
  final pdfFile = PdfFile.fromFile(filePath);
  const pageIndex = 1;
  final page = PdfPage(pdfFile.document, pageIndex);
  print("PAGE COUNTS: ${pdfFile.pageCounts}");
  print("Meta: ${pdfFile.getMetaText('Title')}");
  print("Page 0 width: ${page.width}, height: ${page.height}");
  // print("Page 0 text: ${page.getPageText()}");
  final image = page.renderImage(scale: 1.0);
  // File(imgPath).writeAsBytesSync(imageUtil.encodePng(image));
  //final Point point = Point(50.0, 90.0);
  //print(page.getCharIndexAtPos(point));
  final span = PdfTextSpan(pageIndex, 0, 1);
  print(page.getSpanText(span));
  int charIndex = 21;
  final box = page.getCharBox(charIndex);
  print("BOX: $box");
  print('Unicode: ${page.getUnicode(charIndex)}');
  print('Bounded text: ${page.getBoundedText(box)}');
  Point tl = box.topLeft;
  print('Top left: $tl');
  final devicePoint = page.pageToDevice(tl);
  print('Device point: $devicePoint');
  print('Convert back: ${page.deviceToPage(devicePoint)}');
}
