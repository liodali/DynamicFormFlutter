import 'package:dynamicForm/src/element.dart';
import 'package:flutter/material.dart';

enum DirectionGroup { Vertical, Horizontal }

class GroupElement {
  final List<TextElement> textElements;
  final DirectionGroup directionGroup;
  final List<double> sizeElements;

  GroupElement(
      {this.textElements,
      this.directionGroup,
      this.sizeElements = const [],
      })
      : assert(
            sizeElements.isEmpty || sizeElements.reduce((a, b) => a + b) <= 1 ,
            "max sum size of elements is 1");
}
