import 'package:flutter/material.dart';

/// Pre existing  border, labels, icons, and styles
/// used to decorate a Material text field.
/// [filledColor] : the Color of text Field container
/// [focusColor] : the Color of Text Field container when the input is focused
/// [style] : The style on which to base the label, hint, and error styles
abstract class DecorationElement {
  final Color filledColor;
  final Color focusColor;
  final TextStyle style;

  const DecorationElement({
    this.filledColor,
    this.focusColor,
    this.style,
  });
}

///  [borderColor]         : The border Color to display when the InputDecorator does not have the focus.
///  [errorBorderColor]    : The borwidthLineder Color to display when the InputDecorator does have the error. |
///  [focusBorderColor]    : The border Color to display when the InputDecorator does  have the focus.         |
///  [disabledBorderColor] : The border Color to display when the InputDecorator is disabled.                  |
///  [radius]              : radius of the border.                                                             |
///  [widthSide]           : The width of this line of the border                                              |
///  [filledColor]         : base fill color of the decoration                                                 |
///  [focusColor]          : focused fill color of the decoration
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
          style: textStyle,
        );
}

///  [borderColor]         : The border Color to display when the InputDecorator does not have the focus.
///  [errorBorderColor]    : The borwidthLineder Color to display when the InputDecorator does have the error. |
///  [focusBorderColor]    : The border Color to display when the InputDecorator does  have the focus.         |
///  [disabledBorderColor] : The border Color to display when the InputDecorator is disabled.                  |
///  [radius]              : radius of the border.                                                             |
///  [widthSide]           : The width of this line of the border
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
          style: textStyle,
        );
}

///  [radius]              : radius of the border.                                                             |
///  [filledColor]         : base fill color of the decoration                                                 |
///  [focusColor]          : focused fill color of the decoration
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
          style: textStyle,
        );
}


///  [shapeButtonLogin]           : shape of the Button.                                                             |
///  [backgroundColorButton]      : background color of the button                                                 |
///  [widthSubmitButton]          : size width of the button
///  [elevation]                  : elevation of the button(default:2.0)
@Deprecated("use ButtonDecorationElement, will removed in next version")
class ButtonLoginDecorationElement {
  final ShapeBorder shapeButtonLogin;
  final Color backgroundColorButton;
  final double widthSubmitButton;
  final double elevation;

  const ButtonLoginDecorationElement({
    this.shapeButtonLogin = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.backgroundColorButton,
    this.widthSubmitButton = 200,
    this.elevation = 2.0,
  });
}
///  [shapeButtonLogin]           : shape of the Button.                                                             |
///  [backgroundColorButton]      : background color of the button                                                 |
///  [widthSubmitButton]          : size width of the button
///  [elevation]                  : elevation of the button(default:2.0)
class ButtonDecorationElement {
  final ShapeBorder shapeButton;
  final Color backgroundColorButton;
  final double widthSubmitButton;
  final double elevation;

  const ButtonDecorationElement({
    this.shapeButton = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.backgroundColorButton,
    this.widthSubmitButton = 200,
    this.elevation = 2.0,
  });
}

