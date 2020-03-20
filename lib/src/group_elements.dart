import 'package:dynamicform/src/element.dart';

enum DirectionGroup { Vertical, Horizontal }

class GroupElement {
  final List<TextElement> textElements;
  final DirectionGroup directionGroup;
  final List<int> sizeElements;
  GroupElement({this.textElements, this.directionGroup,this.sizeElements}):
  assert(sizeElements.reduce((a,b)=>a+b)==1,"max sum size of elements is 1");
}
