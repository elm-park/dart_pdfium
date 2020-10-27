import 'dart:ffi';
import 'package:ffi/ffi.dart';

str2Int8(String str) {
  return Utf8.toUtf8(str).cast<Int8>();
}