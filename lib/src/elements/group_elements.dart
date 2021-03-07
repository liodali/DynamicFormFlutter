import 'package:dynamic_form/src/elements/element.dart';
import 'package:flutter/material.dart';

enum DirectionGroup { Vertical, Horizontal }

/// [directionGroup]     : Direction of form (Vertical/Horizontal)
/// [sizeElements]       : size of each textElement  of form When direction Horizontal,sum of values should be egal a 1
/// [textElements]       : group of textElement.
/// [padding]            : padding of groups.
/// [decoration]         : decoration  of container groups.
/// [backgroundColor]    : color of the container groups.
class GroupElement {
  final List<TextElement?>? textElements;
  final DirectionGroup? directionGroup;
  final List<double> sizeElements;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final Color backgroundColor;

  GroupElement({
    this.textElements,
    this.directionGroup,
    this.padding,
    this.margin,
    this.decoration,
    this.backgroundColor = Colors.white,
    this.sizeElements = const [],
  }) : assert(sizeElements.isEmpty || sizeElements.reduce((a, b) => a + b) <= 1,
            "max sum size of elements is 1");
}
