import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class Constants {
  static TextInputType getInput(TypeInput typeInput) {
    switch (typeInput) {
      case TypeInput.Email:
        return TextInputType.emailAddress;
        break;
      case TypeInput.Numeric:
        return TextInputType.number;
        break;
      case TypeInput.Address:
        return TextInputType.text;
        break;
      case TypeInput.Text:
      case TypeInput.Password:
        return TextInputType.text;
        break;
      case TypeInput.Phone:
        return TextInputType.phone;
        break;
      case TypeInput.multiLine:
        return TextInputType.multiline;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  static InputDecoration setInputBorder(
      BuildContext context, DecorationElement decorationElement) {
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
          borderRadius: decorationElement.radius ??
              BorderRadius.all(
                Radius.circular(25.0),
              ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ??
              BorderRadius.all(
                Radius.circular(25.0),
              ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ??
              BorderRadius.all(
                Radius.circular(25.0),
              ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ??
              BorderRadius.all(
                Radius.circular(25.0),
              ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: decorationElement.radius ??
              BorderRadius.all(
                Radius.circular(25.0),
              ),
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
}
