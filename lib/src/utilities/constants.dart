import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CountryFlagSize {
  w20,
  w40,
  w80,
  w160,
}

extension CountryFlagSizeValues on CountryFlagSize {
  static List<String> values = ["w20", "w40", "w80", "w160"];

  String get value => values[index];
}

extension parsing on DateTime {
  DateTime parseFormat(DateFormat format) {
    return format.parse(format.format(this));
  }
}

class Constants {
  static TextInputType getInput(TypeInput typeInput) {
    switch (typeInput) {
      case TypeInput.Email:
        return TextInputType.emailAddress;
      case TypeInput.Numeric:
        return TextInputType.number;
      case TypeInput.Address:
        return TextInputType.text;
      case TypeInput.Text:
      case TypeInput.Password:
        return TextInputType.text;
      case TypeInput.Phone:
        return TextInputType.phone;
      case TypeInput.multiLine:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  static InputDecoration setInputBorder(
    BuildContext context,
    DecorationElement? decorationElement, {
    DecorationElement? common,
  }) {
    var commonRadius = BorderRadius.zero;
    var commonWidthSide = 1.0;
    var commonFocusWidthSide = 1.0;
    if (common != null && common.radius != null) {
      commonRadius = common.radius!;
    }
    if (common != null) {
      if (common is UnderlineDecorationElement && common.widthSide != null) {
        commonWidthSide = common.widthSide!;
      } else if (common is OutlineDecorationElement &&
          common.widthSide != null) {
        commonWidthSide = common.widthSide!;
      }
      if (common is UnderlineDecorationElement &&
          common.focusWidthSide != null) {
        commonFocusWidthSide = common.focusWidthSide!;
      } else if (common is OutlineDecorationElement &&
          common.focusWidthSide != null) {
        commonFocusWidthSide = common.focusWidthSide!;
      }
    }
    InputDecoration inputDecoration = InputDecoration(
      fillColor: common?.filledColor,
      contentPadding:
          decorationElement?.contentPadding ?? common?.contentPadding,
      filled: common?.filledColor != null ? true : false,
      labelStyle: decorationElement?.style ??
          common?.labelStyle ??
          Theme.of(context).inputDecorationTheme.labelStyle,
      errorStyle: decorationElement?.styleError ??
          common?.labelStyle ??
          Theme.of(context).inputDecorationTheme.labelStyle,
      hintStyle: decorationElement?.hintStyle ??
          common?.labelStyle ??
          Theme.of(context).inputDecorationTheme.hintStyle,
    );
    final decoration = decorationElement ?? common;
    if (decoration != null) {
      late InputBorder inputBorder,
          focusInputBorder,
          errorInputBorder,
          focusErrorInputBorder,
          disableInputBorder;
      switch (decoration.runtimeType) {
        case UnderlineDecorationElement:
        case UnderlinePasswordElementDecoration:
          inputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: (decoration as UnderlineDecorationElement).borderColor ??
                  Colors.grey,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          errorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          focusErrorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.focusWidthSide ?? commonWidthSide,
            ),
          );
          focusInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color:
                  decoration.focusBorderColor ?? Theme.of(context).primaryColor,
              width: decoration.focusWidthSide ?? commonFocusWidthSide,
            ),
          );
          disableInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.disabledBorderColor ??
                  Theme.of(context).disabledColor,
              width: decoration.widthSide ?? commonFocusWidthSide,
            ),
          );
          break;
        case OutlineDecorationElement:
        case OutlinePasswordElementDecoration:
          inputBorder = OutlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: (decoration as OutlineDecorationElement).borderColor ??
                  Colors.grey,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          focusErrorInputBorder = OutlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.focusWidthSide ?? commonWidthSide,
            ),
          );
          focusInputBorder = OutlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color:
                  decoration.focusBorderColor ?? Theme.of(context).primaryColor,
              width: decoration.focusWidthSide ?? commonFocusWidthSide,
            ),
          );
          disableInputBorder = OutlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.disabledBorderColor ??
                  Theme.of(context).disabledColor,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          errorInputBorder = OutlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          break;
        case RoundedDecorationElement:
        case RoundedPasswordElementDecoration:
          inputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          );
          focusInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          );
          errorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          );
          disableInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          );
          focusErrorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          );
          break;
        default:
          inputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: (decoration as UnderlineDecorationElement).borderColor ??
                  Colors.grey,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          errorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.widthSide ?? commonWidthSide,
            ),
          );
          focusErrorInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.errorBorderColor,
              width: decoration.focusWidthSide ?? commonWidthSide,
            ),
          );
          focusInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color:
                  decoration.focusBorderColor ?? Theme.of(context).primaryColor,
              width: decoration.focusWidthSide ?? commonFocusWidthSide,
            ),
          );
          disableInputBorder = UnderlineInputBorder(
            borderRadius: decoration.radius ?? commonRadius,
            borderSide: BorderSide(
              color: decoration.disabledBorderColor ??
                  Theme.of(context).disabledColor,
              width: decoration.widthSide ?? commonFocusWidthSide,
            ),
          );
      }
      inputDecoration = inputDecoration.copyWith(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedErrorBorder: focusErrorInputBorder,
        focusedBorder: focusInputBorder,
        errorBorder: errorInputBorder,
        disabledBorder: disableInputBorder,
        fillColor: decoration.filledColor,
        filled: decoration.filledColor != null ? true : false,
        focusColor: decoration.focusColor,
      );
    }

    if (decorationElement?.suffix != null) {
      inputDecoration = inputDecoration.copyWith(
        suffixIcon: decorationElement?.suffix,
      );
    }

    if (decorationElement?.prefix != null) {
      inputDecoration = inputDecoration.copyWith(
        prefixIcon: decorationElement?.prefix,
      );
    }
    if (decorationElement?.contentPadding != null) {
      inputDecoration = inputDecoration.copyWith(
        contentPadding: decorationElement?.contentPadding ??
            common?.contentPadding ??
            EdgeInsets.zero,
      );
    }

    return inputDecoration;
  }

  static fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null) currentFocus.unfocus();
    if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
  }
}

Widget? buildCounter(
  ctx, {
  required int currentLength,
  int? maxLength,
  required bool isFocused,
}) {
  return null;
}
