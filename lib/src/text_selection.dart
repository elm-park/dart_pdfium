import 'package:equatable/equatable.dart';

class TextSelection extends Equatable {
  final int startPage;
  final int endPage;
  final int startIndex;
  final int endIndex;
  TextSelection(this.startPage, this.startIndex, this.endPage, this.endIndex);

  @override
  List<Object> get props => [startPage, startIndex, endPage, endIndex];
}
