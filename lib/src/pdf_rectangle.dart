import 'dart:html';

import 'package:equatable/equatable.dart';

class PdfRectangle extends Equatable {
  final int pageIndex;
  final Rectangle bounds;

  PdfRectangle(this.pageIndex, this.bounds);

  @override
  List<Object> get props => [pageIndex, bounds];
}
