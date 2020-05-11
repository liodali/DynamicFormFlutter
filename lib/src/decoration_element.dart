import 'package:flutter/material.dart';

abstract class DecorationElement {
  final Color filledColor;
  final Color focusColor;
  final TextStyle style;

  const DecorationElement({this.filledColor, this.focusColor, this.style});
}

class UnderlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthSide;

  const UnderlineDecorationElement({
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
            filledColor: filledColor ?? Colors.white,
            focusColor: focusColor ?? Colors.white,
            style: textStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ));
}

class OutlineDecorationElement extends DecorationElement {
  final Color borderColor;
  final Color errorBorderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final BorderRadius radius;
  final double widthSide;

  const OutlineDecorationElement({
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
            filledColor: filledColor ?? Colors.white,
            focusColor: focusColor ?? Colors.white,
            style: textStyle ??
                const TextStyle(color: Colors.black, fontSize: 14));
}

class RoundedDecorationElement extends DecorationElement {
  final BorderRadius radius;

  const RoundedDecorationElement({
    this.radius = const BorderRadius.all(Radius.circular(25.0)),
    Color filledColor,
    Color focusColor,
    TextStyle textStyle,
  }) : super(
            filledColor: filledColor ?? Colors.white,
            focusColor: focusColor ?? Colors.white,
            style: textStyle ??
                const TextStyle(color: Colors.black, fontSize: 14));
}

class ButtonLoginDecorationElement {
  final double radiusBorderButton;
  final Color backgroundColorButton;
  final double widthSubmitButton;

  const ButtonLoginDecorationElement({
    this.radiusBorderButton = 5.0,
    this.backgroundColorButton,
    this.widthSubmitButton = 200,
  });
}
