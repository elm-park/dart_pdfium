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
          parameterTypes: ['*FPDF_LIBRARY_CONFIG'],
          parameterNames: ['config'],
          returnType: 'void'
        ),
      
        Func(
            name: "FPDF_SetSandBoxPolicy",
            parameterTypes: ['uint32', 'int32'],
            parameterNames: ['policy', 'enable'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_LoadDocument",
            parameterTypes: ['*utf8', '*utf8'],
            parameterNames: ['file_path', 'password'],
            returnType: "*FPDF_DOCUMENT"
        ),
        Func(
            name: "FPDF_LoadMemDocument",
            parameterTypes: ['void', 'int32', '*utf8'],
            parameterNames: ['data_buf', 'size', 'password'],
            returnType: "*FPDF_DOCUMENT"
        ),
        Func(
            name: "FPDF_LoadMemDocument64",
            parameterTypes: ['void', 'uint32', '*char'],
            parameterNames: ['data_buf', 'size', 'password'],
            returnType: "*FPDF_DOCUMENT"
        ),
        Func(
            name: "FPDF_LoadCustomDocument",
            parameterTypes: ['*FPDF_FILEACCESS', '*utf8'],
            parameterNames: ['pFileAccess', 'password'],
            returnType: "*FPDF_DOCUMENT"
        ),
        Func(
            name: "FPDF_GetFileVersion",
            parameterTypes: ['*FPDF_DOCUMENT', 'int32'],
            parameterNames: ['doc', 'fileVersion'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_DocumentHasValidCrossReferenceTable",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_GetDocPermissions",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "uint32"
        ),
        Func(
            name: "FPDF_GetSecurityHandlerRevision",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_GetPageCount",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_LoadPage",
            parameterTypes: ['*FPDF_DOCUMENT', 'int32'],
            parameterNames: ['document', 'page_index'],
            returnType: "*FPDF_PAGE"
        ),
        Func(
            name: "FPDF_GetPageWidthF",
            parameterTypes: ['*FPDF_PAGE'],
            parameterNames: ['page'],
            returnType: "float"
        ),
        Func(
            name: "FPDF_GetPageWidth",
            parameterTypes: ['*FPDF_PAGE'],
            parameterNames: ['page'],
            returnType: "double"
        ),
        Func(
            name: "FPDF_GetPageHeightF",
            parameterTypes: ['*FPDF_PAGE'],
            parameterNames: ['page'],
            returnType: "float"
        ),
        Func(
            name: "FPDF_GetPageHeight",
            parameterTypes: ['*FPDF_PAGE'],
            parameterNames: ['page'],
            returnType: "double"
        ),
        Func(
            name: "FPDF_GetPageBoundingBox",
            parameterTypes: ['*FPDF_PAGE', '*FS_RECTF'],
            parameterNames: ['page', 'rect'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_GetPageSizeByIndexF",
            parameterTypes: ['*FPDF_DOCUMENT', 'int32', '*FS_SIZEF'],
            parameterNames: ['document', 'page_index', 'size'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_GetPageSizeByIndex",
            parameterTypes: ['*FPDF_DOCUMENT', 'int32', 'double', 'double'],
            parameterNames: ['document', 'page_index', 'width', 'height'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_RenderPageBitmap",
            parameterTypes: ['*FPDF_BITMAP', '*FPDF_PAGE', 'int32', 'int32', 'int32', 'int32', 'int32', 'int32'],
            parameterNames: ['bitmap', 'page', 'start_x', 'start_y', 'size_x', 'size_y', 'rotate', 'flags'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_RenderPageBitmapWithMatrix",
            parameterTypes: ['*FPDF_BITMAP', '*FPDF_PAGE', '*FS_MATRIX', '*FS_RECTF', 'int32'],
            parameterNames: ['bitmap', 'page', 'matrix', 'clipping', 'flags'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_ClosePage",
            parameterTypes: ['*FPDF_PAGE'],
            parameterNames: ['page'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_CloseDocument",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_DeviceToPage",
            parameterTypes: ['*FPDF_PAGE', 'int32', 'int32', 'int32', 'int32', 'int32', 'int32', 'int32', 'double', 'double'],
            parameterNames: ['page', 'start_x', 'start_y', 'size_x', 'size_y', 'rotate', 'device_x', 'device_y', 'page_x', 'page_y'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_PageToDevice",
            parameterTypes: ['*FPDF_PAGE', 'int32', 'int32', 'int32', 'int32', 'int32', 'double', 'double', 'int32', 'int32'],
            parameterNames: ['page', 'start_x', 'start_y', 'size_x', 'size_y', 'rotate', 'page_x', 'page_y', 'device_x', 'device_y'],
            returnType: "int32"
        ),
        Func(
            name: "FPDFBitmap_Create",
            parameterTypes: ['int32', 'int32', 'int32'],
            parameterNames: ['width', 'height', 'alpha'],
            returnType: "*FPDF_BITMAP"
        ),
        Func(
            name: "FPDFBitmap_CreateEx",
            parameterTypes: ['int32', 'int32', 'int32', 'void', 'int32'],
            parameterNames: ['width', 'height', 'format', 'first_scan', 'stride'],
            returnType: "*FPDF_BITMAP"
        ),
        Func(
            name: "FPDFBitmap_GetFormat",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "int32"
        ),
        Func(
            name: "FPDFBitmap_FillRect",
            parameterTypes: ['*FPDF_BITMAP', 'int32', 'int32', 'int32', 'int32', 'uint32'],
            parameterNames: ['bitmap', 'left', 'top', 'width', 'height', 'color'],
            returnType: "void"
        ),
        Func(
            name: "FPDFBitmap_GetBuffer",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "*int32"
        ),
        Func(
            name: "FPDFBitmap_GetWidth",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "int32"
        ),
        Func(
            name: "FPDFBitmap_GetHeight",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "int32"
        ),
        Func(
            name: "FPDFBitmap_GetStride",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "int32"
        ),
        Func(
            name: "FPDFBitmap_Destroy",
            parameterTypes: ['*FPDF_BITMAP'],
            parameterNames: ['bitmap'],
            returnType: "void"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetPrintScaling",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetNumCopies",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetPrintPageRange",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "*FPDF_PAGERANGE"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetPrintPageRangeCount",
            parameterTypes: ['*FPDF_PAGERANGE'],
            parameterNames: ['pagerange'],
            returnType: "uint32"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetPrintPageRangeElement",
            parameterTypes: ['*FPDF_PAGERANGE', 'uint32'],
            parameterNames: ['pagerange', 'index'],
            returnType: "int32"
        ),
        Func(
            name: "FPDF_VIEWERREF_GetName",
            parameterTypes: ['*FPDF_DOCUMENT', '*char', 'char', 'uint32'],
            parameterNames: ['document', 'key', 'buffer', 'length'],
            returnType: "uint32"
        ),
        Func(
            name: "FPDF_CountNamedDests",
            parameterTypes: ['*FPDF_DOCUMENT'],
            parameterNames: ['document'],
            returnType: "uint32"
        ),
        Func(
            name: "FPDF_GetNamedDestByName",
            parameterTypes: ['*FPDF_DOCUMENT', '*char'],
            parameterNames: ['document', 'name'],
            returnType: "*FPDF_DEST"
        ),
        Func(
            name: "FPDF_GetNamedDest",
            parameterTypes: ['*FPDF_DOCUMENT', 'int32', 'void', 'int32'],
            parameterNames: ['document', 'index', 'buffer', 'buflen'],
            returnType: "*FPDF_DEST"
        )
  ],
);
