import 'package:flutter/material.dart';

abstract class DecorationElement {}

class UnderlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthLine;
  final Color filledColor;
  final Color focusColor;

  UnderlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.radius=const BorderRadius.all(Radius.circular(0.0)),
    this.widthLine,
    this.filledColor,
    this.focusColor,
  });
}

class OutlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthLine;
  final Color filledColor;
  final Color focusColor;

  OutlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.radius=const BorderRadius.all(Radius.circular(0.0)),
    this.widthLine,
    this.filledColor,
    this.focusColor,
  });
}

class RoundedDecorationElement extends DecorationElement {
  final BorderRadius radius;
  final Color filledColor;
  final Color focusColor;

  RoundedDecorationElement({
    this.radius = const BorderRadius.all(Radius.circular(25.0)),
    this.filledColor,
    this.focusColor,
  });
}
