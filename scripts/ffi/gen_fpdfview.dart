import 'package:ffi_tool/c.dart';
import 'dart:io';

///Keep function and variable names consist with PDFium
void main() {
  generateFile(File("lib/src/pdfium_ffi.dart"), library, format: false);
}

final library = Library(
  dynamicLibraryPath:
      "/Users/zhonghua/programs/pdfium-darwin-v8/lib/libpdfium.dylib",
  importedUris: {
    ImportedUri('structs.dart'),
  },
  elements: <Element>[
    Func(
        name: 'FPDF_InitLibraryWithConfig',
        documentation: 'Initialize the FPDFSDK library',
        parameterTypes: ['*FPDF_LIBRARY_CONFIG'],
        returnType: 'void'),
    Func(name: 'FPDF_DestroyLibrary', parameterTypes: [], returnType: 'void'),
    Func(
        name: 'FPDF_LoadDocument',
        parameterNames: ['file_path', 'password'],
        parameterTypes: ['*utf8', '*utf8'],
        returnType: '*FPDF_DOCUMENT'),
    Func(
        name: 'FPDF_CloseDocument',
        parameterNames: ['document'],
        parameterTypes: ['*FPDF_DOCUMENT'],
        returnType: 'void'),
    Func(
        name: 'FPDF_LoadPage',
        parameterNames: ['document', 'page'],
        parameterTypes: ['*FPDF_DOCUMENT', 'int32'],
        returnType: '*FPDF_PAGE'),
    Func(
        name: 'FPDF_GetPageCount',
        parameterNames: ['document'],
        parameterTypes: ['*FPDF_DOCUMENT'],
        returnType: 'int32'),
    Func(
        name: 'FPDFBitmap_Create',
        parameterNames: ['width', 'height', 'alpha'],
        parameterTypes: ['int32', 'int32', 'int32'],
        returnType: '*FPDF_BITMAP'),
    Func(
        name: 'FPDFBitmap_CreateEx',
        parameterNames: ['width', 'height', 'format', 'first_scan', 'stride'],
        parameterTypes: ['int32', 'int32', 'int32', '*int32', 'int32'],
        returnType: '*FPDF_BITMAP'),
    Func(
        name: 'FPDFBitmap_FillRect',
        parameterNames: ['bitmap', 'left', 'top', 'width', 'height', 'color'],
        parameterTypes: [
          '*FPDF_BITMAP',
          'int32',
          'int32',
          'int32',
          'int32',
          'int32'
        ],
        returnType: 'void'),
    Func(
        name: 'FPDFBitmap_GetBuffer',
        parameterNames: ['bitmap'],
        parameterTypes: ['*FPDF_BITMAP'],
        returnType: '*int32'),
    Func(
        name: 'FPDF_RenderPageBitmap',
        parameterNames: [
          'bitmap',
          'page',
          'start_x',
          'start_y',
          'size_x',
          'size_y',
          'rotate',
          'flag'
        ],
        parameterTypes: [
          '*FPDF_BITMAP',
          '*FPDF_PAGE',
          'int32',
          'int32',
          'int32',
          'int32',
          'int32',
          'int32'
        ],
        returnType: 'void'),
    Func(
        name: 'FPDF_GetPageWidth',
        parameterNames: ['page'],
        parameterTypes: ['*FPDF_PAGE'],
        returnType: 'double'),
    Func(
        name: 'FPDF_GetPageHeight',
        parameterNames: ['page'],
        parameterTypes: ['*FPDF_PAGE'],
        returnType: 'double'),

    ////////////////////fpdf_edit.h
    ///
    Func(
        name: 'FPDFPage_CountObjects',
        parameterNames: ['page'],
        parameterTypes: ['*FPDF_PAGE'],
        returnType: 'int32'),
    Func(
        name: 'FPDFImageObj_GetBitmap',
        documentation:
            'Get a bitmap rasterisation of |image_object|. The returned bitmap will be owned by the caller, and FPDFBitmap_Destroy() must be called on the returned bitmap when it is no longer needed.',
        parameterNames: ['image_object'],
        parameterTypes: ['*FPDF_PAGEOBJECT'],
        returnType: '*FPDF_BITMAP'),
    Func(
        name: 'FPDFPage_GetObject',
        parameterNames: ['page', 'index'],
        parameterTypes: ['*FPDF_PAGE', 'int32'],
        returnType: '*FPDF_PAGEOBJECT'),
    //Func(name: null, parameterTypes: null, returnType: null)

    ///fpdf_text.h
    ///
    Func(
        name: 'FPDFText_GetCharOrigin',
        parameterNames: ['text_page', 'index', 'x', 'y'],
        parameterTypes: ['*FPDF_TEXTPAGE', 'int32', '*double', '*double'],
        returnType: 'int32'),
    Func(
        name: 'FPDFText_GetCharIndexAtPos',
        parameterNames: ['text_page', 'x', 'y', 'xTolerance', 'yTolerance'],
        parameterTypes: [
          '*FPDF_TEXTPAGE',
          'double',
          'double',
          'double',
          'double'
        ],
        returnType: 'int32'),
    Func(
        name: 'FPDFText_GetText',
        parameterNames: ['text_page', 'start_index', 'count', 'result'],
        parameterTypes: ['*FPDF_TEXTPAGE', 'int32', 'int32', '*int8'],
        returnType: 'int32'),
    Func(
        name: 'FPDFText_LoadPage',
        parameterNames: ['page'],
        parameterTypes: ['*FPDF_PAGE'],
        returnType: '*FPDF_TEXTPAGE'),
  ],
);
