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
  static List<String> values = ["w20","w40","w80","w160"];

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
      BuildContext context, DecorationElement? decorationElement) {
    if (decorationElement is UnderlineDecorationElement) {
      return InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ??
                Theme.of(context).primaryColor,
            width: decorationElement.widthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is OutlineDecorationElement) {
      return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.borderColor ?? Colors.grey,
            width: decorationElement.widthSide,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.focusBorderColor ??
                Theme.of(context).primaryColor,
            width: decorationElement.widthSide,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.errorBorderColor,
            width: decorationElement.widthSide,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: decorationElement.disabledBorderColor ??
                Theme.of(context).disabledColor,
            width: decorationElement.widthSide,
          ),
        ),
        fillColor: decorationElement.filledColor,
        focusColor: decorationElement.focusColor,
        filled: decorationElement.filledColor != null ? true : false,
      );
    } else if (decorationElement is RoundedDecorationElement) {
      return InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius,
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
    return InputDecoration();
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
