library dart_pdfium;

import 'dart:ffi';
import 'ffi_gen/ffi_gen.dart';

export 'ffi_gen/ffi_gen.dart';

const PDFIUM_FILE =
    '/Users/zhonghua/programs/pdfium-darwin-v8/lib/libpdfium.dylib';
const MAX_META_LENGTH = 4096;

class MetaTag {
  static const tagList = [
    "Title",
    "Author",
    "Subject",
    "Keywords",
    "Creator",
    "Producer",
    "CreationDate",
    "ModDate",
  ];
  static const title = "Title";
  static const author = "Author";
  static const subject = "Subject";
  static const keywords = "Keywords";
  static const creator = "Creator";
  static const producer = "Producer";
  static const creationDate = "CreationDate";
  static const modDate = "ModDate";
}

class Pdfium {
  NativeLibrary lib;
  static final Pdfium _pdfium = Pdfium._internal();

  factory Pdfium() {
    return _pdfium;
  }

  Pdfium._internal() {
    //TODO: check file existence
    //TODO: platform specific dylib
    lib = NativeLibrary(DynamicLibrary.open(PDFIUM_FILE));
    lib.FPDF_InitLibraryWithConfig(nullptr);
  }
}
