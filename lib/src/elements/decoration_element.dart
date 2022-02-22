import 'package:flutter/material.dart';

/// Pre existing  border, labels, icons, and styles
/// used to decorate a Material text field.
/// [filledColor] : the Color of text Field container
///
/// [focusColor] : the Color of Text Field container when the input is focused
///
/// [style] : The style on which to base the label, hint, and error styles
///
abstract class DecorationElement {
  final BorderRadius? radius;
  final Color? filledColor;
  final Color? focusColor;
  final TextStyle? style;
  final TextStyle? styleError;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsetsGeometry? contentPadding;

  const DecorationElement({
    this.radius,
    this.filledColor,
    this.focusColor,
    this.style,
    this.styleError,
    this.hintStyle,
    this.labelStyle,
    this.prefix,
    this.suffix,
    this.contentPadding,
  });

  DecorationElement copy({
    BorderRadius? radius,
    Color? filledColor,
    Color? focusColor,
    TextStyle? style,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? styleError,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefix,
    Widget? suffix,
  });
}

///  [borderColor]         : The border Color to display when the InputDecorator does not have the focus.
///  [errorBorderColor]    : The borwidthLineder Color to display when the InputDecorator does have the error. |
///  [focusBorderColor]    : The border Color to display when the InputDecorator does  have the focus.         |
///  [disabledBorderColor] : The border Color to display when the InputDecorator is disabled.                  |
///  [widthSide]           : The width of this line of the border                                              |
///  [filledColor]         : base fill color of the decoration                                                 |
///  [focusColor]          : focused fill color of the decoration
class UnderlineDecorationElement extends DecorationElement {
  final Color? borderColor;
  final Color errorBorderColor;
  final Color? focusBorderColor;
  final Color? disabledBorderColor;
  final double? widthSide;
  final double? focusWidthSide;

  const UnderlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? radius,
    this.widthSide,
    this.focusWidthSide,
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? textErrorStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    Widget? prefix,
    Widget? suffix,
  }) : super(
          radius: radius,
          filledColor: filledColor ?? Colors.white,
          focusColor: focusColor ?? Colors.white,
          style: textStyle,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          styleError: textErrorStyle,
          prefix: prefix,
          suffix: suffix,
          contentPadding: contentPadding,
        );

  @override
  DecorationElement copy({
    Color? borderColor,
    Color errorBorderColor = Colors.red,
    Color? focusBorderColor,
    Color? disabledBorderColor,
    BorderRadius? radius = const BorderRadius.all(Radius.circular(0.0)),
    double widthSide = 1.0,
    double focusWidthSide = 1.0,
    Color? filledColor,
    Color? focusColor,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? styleError,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return UnderlineDecorationElement(
      borderColor: borderColor ?? this.borderColor,
      errorBorderColor: errorBorderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      radius: radius ?? this.radius,
      widthSide: widthSide,
      focusWidthSide: focusWidthSide,
      focusColor: focusColor ?? this.focusColor,
      textStyle: style ?? this.style,
      hintStyle: hintStyle ?? this.labelStyle,
      labelStyle: labelStyle ?? this.hintStyle,
      textErrorStyle: styleError ?? this.styleError,
      filledColor: filledColor,
      contentPadding: contentPadding,
      prefix: prefix,
      suffix: suffix,
    );
  }
}

///  [borderColor]         : The border Color to display when the InputDecorator does not have the focus.
///  [errorBorderColor]    : The borwidthLineder Color to display when the InputDecorator does have the error. |
///  [focusBorderColor]    : The border Color to display when the InputDecorator does  have the focus.         |
///  [disabledBorderColor] : The border Color to display when the InputDecorator is disabled.                  |
///  [radius]              : radius of the border.                                                             |
///  [widthSide]           : The width of this line of the border
class OutlineDecorationElement extends DecorationElement {
  final Color? borderColor;
  final Color errorBorderColor;
  final Color? focusBorderColor;
  final Color? disabledBorderColor;
  final double? widthSide;
  final double? focusWidthSide;

  const OutlineDecorationElement({
    this.borderColor,
    this.errorBorderColor = Colors.red,
    this.focusBorderColor,
    this.disabledBorderColor,
    BorderRadius? radius,
    this.widthSide,
    this.focusWidthSide,
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? textErrorStyle,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) : super(
          radius: radius,
          filledColor: filledColor ?? Colors.white,
          focusColor: focusColor ?? Colors.white,
          style: textStyle,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          styleError: textErrorStyle,
          contentPadding: contentPadding,
          prefix: prefix,
          suffix: suffix,
        );

  @override
  DecorationElement copy({
    Color? borderColor,
    Color? errorBorderColor,
    Color? focusBorderColor,
    Color? disabledBorderColor,
    double? widthSide,
    double? focusWidthSide,
    BorderRadius? radius,
    Color? filledColor,
    Color? focusColor,
    TextStyle? style,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? styleError,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return OutlineDecorationElement(
      radius: radius ?? this.radius,
      borderColor: borderColor ?? this.borderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      widthSide: widthSide ?? this.widthSide,
      focusWidthSide: focusWidthSide ?? this.focusWidthSide,
      filledColor: filledColor ?? this.filledColor,
      focusColor: focusColor ?? this.focusColor,
      textStyle: style ?? this.style,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      textErrorStyle: styleError ?? this.styleError,
      contentPadding: contentPadding,
      prefix: prefix,
      suffix: suffix,
    );
  }
}

///  [radius]              : radius of the border.
class RoundedDecorationElement extends DecorationElement {
  const RoundedDecorationElement({
    BorderRadius? radius = const BorderRadius.all(Radius.circular(25.0)),
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? styleError,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) : super(
          radius: radius,
          filledColor: filledColor ?? Colors.white,
          focusColor: focusColor ?? Colors.white,
          style: textStyle,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          styleError: styleError,
          contentPadding: contentPadding,
          suffix: suffix,
          prefix: prefix,
        );

  @override
  DecorationElement copy({
    BorderRadius? radius,
    Color? filledColor,
    Color? focusColor,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? styleError,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return RoundedDecorationElement(
      radius: radius  ?? this.radius,
      filledColor: filledColor ?? this.filledColor,
      focusColor: focusColor ?? this.focusColor,
      textStyle: style ?? this.style,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      styleError: styleError ?? this.styleError,
      contentPadding: contentPadding,
      prefix: prefix,
      suffix: suffix,
    );
  }
}

abstract class PasswordElementDecoration extends DecorationElement {
  abstract final Widget? showPasswordWidget;
  abstract final Widget? hidePasswordWidget;
  abstract final bool enableVisibilityPassword;
}

class UnderlinePasswordElementDecoration extends UnderlineDecorationElement
    implements PasswordElementDecoration {
  final Widget? showPasswordWidget;
  final Widget? hidePasswordWidget;
  final bool enableVisibilityPassword;

  const UnderlinePasswordElementDecoration({
    this.showPasswordWidget,
    this.hidePasswordWidget,
    this.enableVisibilityPassword = true,
    Color? borderColor,
    Color errorBorderColor = Colors.red,
    Color? focusBorderColor,
    Color? disabledBorderColor,
    BorderRadius radius = BorderRadius.zero,
    double widthSide = 1,
    EdgeInsetsGeometry? contentPadding,
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? textErrorStyle,
    Widget? prefix,
  }) : super(
          borderColor: borderColor,
          filledColor: filledColor,
          focusBorderColor: focusBorderColor,
          focusColor: focusColor,
          textStyle: textStyle,
          hintStyle: labelStyle,
          labelStyle: hintStyle,
          textErrorStyle: textErrorStyle,
          widthSide: widthSide,
          errorBorderColor: errorBorderColor,
          disabledBorderColor: disabledBorderColor,
          radius: radius,
          contentPadding: contentPadding,
          suffix: null,
          prefix: prefix,
        );
}

class OutlinePasswordElementDecoration extends OutlineDecorationElement
    implements PasswordElementDecoration {
  final Widget? showPasswordWidget;
  final Widget? hidePasswordWidget;
final bool enableVisibilityPassword;
  const OutlinePasswordElementDecoration({
    this.showPasswordWidget,
    this.hidePasswordWidget,
    this.enableVisibilityPassword = true,
    Color? borderColor,
    Color errorBorderColor = Colors.red,
    Color? focusBorderColor,
    Color? disabledBorderColor,
    BorderRadius? radius,
    double widthSide = 1,
    EdgeInsetsGeometry? contentPadding,
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? textErrorStyle,
    Widget? prefix,
  }) : super(
          borderColor: borderColor,
          filledColor: filledColor,
          focusBorderColor: focusBorderColor,
          focusColor: focusColor,
          textStyle: textStyle,
          hintStyle: labelStyle,
          labelStyle: hintStyle,
          textErrorStyle: textErrorStyle,
          widthSide: widthSide,
          errorBorderColor: errorBorderColor,
          disabledBorderColor: disabledBorderColor,
          radius: radius,
          contentPadding: contentPadding,
          suffix: null,
          prefix: prefix,
        );
}

class RoundedPasswordElementDecoration extends RoundedDecorationElement
    implements PasswordElementDecoration {
  final Widget? showPasswordWidget;
  final Widget? hidePasswordWidget;
  final bool enableVisibilityPassword;

  const RoundedPasswordElementDecoration({
    this.showPasswordWidget,
    this.hidePasswordWidget,
    this.enableVisibilityPassword = true,
    BorderRadius radius = const BorderRadius.all(Radius.circular(25.0)),
    Color? filledColor,
    Color? focusColor,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? textErrorStyle,
    Widget? prefix,
    Widget? suffix,
    EdgeInsetsGeometry? contentPadding,
  }) : super(
          filledColor: filledColor ?? Colors.white,
          focusColor: focusColor ?? Colors.white,
          textStyle: textStyle,
          hintStyle: labelStyle,
          labelStyle: hintStyle,
          styleError: textErrorStyle,
          contentPadding: contentPadding,
          suffix: suffix,
          prefix: prefix,
          radius: radius,
        );
}

class DecorationLoginForm {
  final DecorationElement? commonDecoration;
  final DecorationElement decorationEmailElement;
  final PasswordElementDecoration decorationPasswordElement;
  final String? login;
  final String? hintLogin;
  final String? password;
  final String? hintPassword;

  DecorationLoginForm({
    this.commonDecoration,
    required this.decorationEmailElement,
    required this.decorationPasswordElement,
    this.login,
    this.password,
    this.hintLogin,
    this.hintPassword,
  });
}

///  [shapeButton]                : shape of the Button.                                                             |
///  [backgroundColorButton]      : background color of the button                                                 |
///  [size]                       : customize size of the button
///  [elevation]                  : elevation of the button(default:2.0)
class ButtonDecorationElement {
  final ShapeBorder shapeButton;
  final Color? backgroundColorButton;
  final double elevation;
  final Size? size;

  const ButtonDecorationElement({
    this.shapeButton = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.backgroundColorButton,
    this.size = const Size.fromWidth(200),
    this.elevation = 2.0,
  });
}
