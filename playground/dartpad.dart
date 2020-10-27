import 'package:ffi/ffi.dart';
import 'dart:ffi';

void main() {
  String test = 'Acrobat Distiller 10.1.8 (Windows); modified using iText® 5.3.5 ©2000-2012 1T3XT BVBA (SPRINGER SBM; licensed version)';
  final li = Utf8.toUtf8(test).cast<Int8>();
  print(Utf8.fromUtf8(li.cast()));
}
