import 'package:equatable/equatable.dart';

class PdfTextSpan extends Equatable {
  final int pageIndex;
  final int offset;
  final int length;

  PdfTextSpan(this.pageIndex, this.offset, this.length);

  @override
  List<Object> get props => [pageIndex, offset, length];

  @override
  bool get stringify => true;
}
