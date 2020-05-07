import 'package:flutter/material.dart';

abstract class DecorationElement {
  final Color filledColor;
  final Color focusColor;
  final TextStyle style;

  DecorationElement({this.filledColor, this.focusColor, this.style});
}

class UnderlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthSide;

  UnderlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.radius = const BorderRadius.all(Radius.circular(0.0)),
    this.widthSide = 1.0,
    Color filledColor,
    Color focusColor,
    TextStyle textStyle,
  }) : super(
            filledColor: filledColor,
            focusColor: focusColor,
            style: textStyle ?? ThemeData.light().textTheme.subtitle1);
}

class OutlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthSide;

  OutlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.radius = const BorderRadius.all(Radius.circular(0.0)),
    this.widthSide = 1.0,
    Color filledColor,
    Color focusColor,
    TextStyle textStyle,
  }) : super(
            filledColor: filledColor,
            focusColor: focusColor,
            style: textStyle ?? ThemeData.light().textTheme.subtitle1);
}

class RoundedDecorationElement extends DecorationElement {
  final BorderRadius radius;

  RoundedDecorationElement({
    this.radius = const BorderRadius.all(Radius.circular(25.0)),
    Color filledColor,
    Color focusColor,
    TextStyle textStyle,
  }) : super(
            filledColor: filledColor,
            focusColor: focusColor,
            style: textStyle ?? ThemeData.light().textTheme.subtitle1);
}
