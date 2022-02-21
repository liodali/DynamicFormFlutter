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
      } else if (common is OutlineDecorationElement && common.widthSide != null) {
        commonWidthSide = common.widthSide!;
      }
      if (common is UnderlineDecorationElement && common.focusWidthSide != null) {
        commonFocusWidthSide = common.focusWidthSide!;
      } else if (common is OutlineDecorationElement && common.focusWidthSide != null) {
        commonFocusWidthSide = common.focusWidthSide!;
      }
    }
    InputDecoration inputDecoration = InputDecoration(
      fillColor: common?.filledColor,
      contentPadding: common?.contentPadding,
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
      constraints: common != null && common.size != null
          ? BoxConstraints(
              maxHeight: common.size?.height ?? MediaQuery.of(context).size.height,
              maxWidth: common.size?.width ?? MediaQuery.of(context).size.width,
            )
          : null,
    );
    if (decorationElement is UnderlinePasswordElementDecoration) {
      inputDecoration = inputDecoration.copyWith(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ?? Theme.of(context).primaryColor,
            width: decorationElement.focusWidthSide ?? commonFocusWidthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is OutlinePasswordElementDecoration) {
      inputDecoration = inputDecoration.copyWith(
        border: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ?? Theme.of(context).primaryColor,
            width: decorationElement.focusWidthSide ?? commonFocusWidthSide,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.disabledBorderColor ?? Theme.of(context).disabledColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is RoundedPasswordElementDecoration) {
      inputDecoration = inputDecoration.copyWith(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        fillColor: decorationElement.filledColor,
        filled: decorationElement.filledColor != null ? true : false,
        focusColor: decorationElement.focusColor,
      );
    } else if (decorationElement is UnderlineDecorationElement) {
      inputDecoration = inputDecoration.copyWith(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ?? Theme.of(context).primaryColor,
            width: decorationElement.focusWidthSide ?? commonFocusWidthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is OutlineDecorationElement) {
      inputDecoration = inputDecoration.copyWith(
        border: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ?? Theme.of(context).primaryColor,
            width: decorationElement.focusWidthSide ?? commonFocusWidthSide,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: decorationElement.disabledBorderColor ?? Theme.of(context).disabledColor,
            width: decorationElement.widthSide ?? commonWidthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is RoundedDecorationElement) {
      inputDecoration = inputDecoration.copyWith(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ?? commonRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        fillColor: decorationElement.filledColor,
        filled: decorationElement.filledColor != null ? true : false,
        focusColor: decorationElement.focusColor,
      );
    }

    if (decorationElement?.suffix != null) {
      inputDecoration = inputDecoration.copyWith(
          //suffixIcon: decorationElement?.suffix,
          );
    }

    if (decorationElement?.prefix != null) {
      inputDecoration = inputDecoration.copyWith(
        prefixIcon: decorationElement?.prefix,
      );
    }
    if (decorationElement?.contentPadding != null) {
      inputDecoration = inputDecoration.copyWith(
        contentPadding:
            decorationElement?.contentPadding ?? common?.contentPadding ?? EdgeInsets.zero,
      );
    }
    if (decorationElement?.size != null) {
      inputDecoration = inputDecoration.copyWith(
        constraints: decorationElement?.size != null
            ? BoxConstraints(
                maxHeight: decorationElement!.size?.height ??
                    common?.size?.height ??
                    MediaQuery.of(context).size.height,
                maxWidth: decorationElement.size?.width ??
                    common?.size?.width ??
                    MediaQuery.of(context).size.width,
              )
            : null,
      );
    }

    return inputDecoration;
  }

  static fieldFocusChange(BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
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
