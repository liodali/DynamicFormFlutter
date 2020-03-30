import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address }

typedef validation = String Function(String);

abstract class FormElement {
  final TypeInput typeInput;
  final String initValue;
  final String label;
  final String hint;
  final String error;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final bool readOnly;

  FormElement({
    this.typeInput,
    this.initValue = "",
    this.label = "",
    this.hint = "",
    this.error = "",
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.readOnly,
  });
}

@immutable
class TextElement extends FormElement {
  final TypeInput typeInput;
  final String initValue;
  final String label;
  final String hint;
  final String error;
  final TextStyle labelStyle;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final validation validator;
  final EdgeInsets padding;
  final bool readOnly;

  TextElement({
    this.typeInput = TypeInput.Text,
    this.initValue,
    this.label = "",
    this.hint = "",
    this.error = "",
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.validator,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
          typeInput: typeInput,
          initValue: initValue,
          label: label,
          hint: hint,
          error: error,
          textStyle: textStyle,
          labelStyle: labelStyle,
          errorStyle: errorStyle,
          hintStyle: hintStyle,
          readOnly: readOnly,
        );
}

class EmailElement extends TextElement {
  final String initValue;
  final String label;
  final String hint;
  final String errorMsg;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final EdgeInsets padding;
  final bool readOnly;

  //final List<String> suffix;
  EmailElement({
    this.initValue,
    this.label,
    this.hint = "example@mail.com",
    this.errorMsg,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.readOnly = false,
    this.padding,

  }) : super(
          initValue: initValue,
          label: label,
          typeInput: TypeInput.Email,
          hint: hint,
          padding:padding,
          readOnly: readOnly,
          validator: (email) {
            if (email.isNotEmpty) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email);
              if (!emailValid) {
                return errorMsg;
              }
            } else {
              return errorMsg;
            }
            return null;
          },
        );
}

class PasswordElement extends TextElement {
  final String initValue;
  final String label;
  final String hint;
  final String errorMsg;
  final enableShowPassword;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool readOnly;

  //final List<String> suffix;
  PasswordElement({
    this.initValue,
    this.label = " Password ",
    this.hint = "password",
    this.errorMsg,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.enableShowPassword = true,
    this.readOnly = false,
  }) : super(
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: readOnly,
          typeInput: TypeInput.Password,
          validator: (password) {
            if (password.isNotEmpty) {
              if (password.length < 6) {
                return "weak password";
              }
            } else {
              return errorMsg;
            }
            return null;
          },
        );
}
class NumberElement extends TextElement{
  final String initValue;
  final String label;
  final String hint;
  final String errorMsg;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool isDigits;
  final bool readOnly;

  //final List<String> suffix;
  NumberElement({
    this.initValue,
    this.label = "",
    this.hint = "",
    this.isDigits=false,
    this.errorMsg,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.readOnly = false,
  }) : super(
    initValue: initValue,
    label: label,
    hint: hint,
    readOnly: readOnly,
    typeInput: TypeInput.Numeric,
    validator: (password) {
      if (password.isNotEmpty) {
        if (password.length < 6) {
          return "weak password";
        }
      } else {
        return errorMsg;
      }
      return null;
    },
  );
}

