import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address }
enum CountryTextResult {
  FullName,
  countryCode,
}

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

class TextElement extends FormElement {
  final TypeInput typeInput;
  final String initValue;
  final Function onTap;
  final String label;
  final String hint;
  final String error;
  final TextStyle labelStyle;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final validation validator;
  final EdgeInsets padding;
  final bool isRequired;
  final bool readOnly;

  TextElement({
    this.typeInput = TypeInput.Text,
    this.initValue,
    this.onTap,
    this.label = "",
    this.hint = "",
    this.error = "",
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.validator,
    this.isRequired = false,
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
  final String errorEmailPattern;
  final String errorEmailIsRequired;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final EdgeInsets padding;
  final bool isRequired;
  final bool readOnly;

  //final List<String> suffix;
  EmailElement({
    this.initValue,
    this.label = "Email",
    this.hint = "example@mail.com",
    this.errorEmailPattern = "invalid email",
    this.errorEmailIsRequired = "email is empty",
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.isRequired = false,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
          initValue: initValue,
          label: label,
          typeInput: TypeInput.Email,
          hint: hint,
          padding: padding,
          readOnly: readOnly,
          validator: (email) {
            if (isRequired) {
              if (email.isEmpty) {
                return errorEmailIsRequired;
              }
            }
            if (email.isNotEmpty) {
              bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email);
              if (!emailValid) {
                return errorEmailPattern;
              }
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
  final bool enableShowPassword;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final EdgeInsets padding;
  final bool isRequired;
  final int minLength;
  final bool hasUppercase;
  final bool hasSpecialCharacter;
  final bool hasDigits;
  final String requiredErrorMsg;
  final String minLengthErrorMsg;
  final String uppercaseErrorMsg;
  final String specialCharacterErrorMsg;
  final String digitsErrorMsg;
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
    this.isRequired,
    this.minLength = 6,
    this.hasUppercase,
    this.hasSpecialCharacter,
    this.hasDigits,
    this.requiredErrorMsg = "Password is required",
    this.minLengthErrorMsg = "",
    this.uppercaseErrorMsg =
        "Password must include at least one uppercase letter ",
    this.specialCharacterErrorMsg =
        "Password must include at least one special character",
    this.digitsErrorMsg =
        "Password must include at least one digit from 0 to 9",
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
          initValue: initValue,
          label: label,
          hint: hint,
          onTap: null,
          readOnly: readOnly,
          typeInput: TypeInput.Password,
          validator: (password) {
            if (password.isNotEmpty) {
              if (password.length < minLength) {
                return minLengthErrorMsg;
              } else if (RegExp("[A-Z]+").stringMatch(password) == null &&
                  hasUppercase) {
                return uppercaseErrorMsg;
              } else if (RegExp("[!@#\$%^&*_]+").stringMatch(password) ==
                      null &&
                  hasSpecialCharacter) {
                return specialCharacterErrorMsg;
              } else if (RegExp(r"\d+").stringMatch(password) == null &&
                  hasDigits) {
                return digitsErrorMsg;
              }
            } else if (isRequired) {
              return requiredErrorMsg;
            }
            return null;
          },
        );
}

class NumberElement extends TextElement {
  final String initValue;
  final String label;
  final validation validator;
  final String hint;
  final String errorMsg;
  final TextStyle textStyle;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool isDigits;
  final EdgeInsets padding;
  final bool readOnly;

  //final List<String> suffix;
  NumberElement({
    this.initValue,
    this.label = "",
    this.hint = "",
    this.isDigits = false,
    this.errorMsg,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.padding = const EdgeInsets.all(2.0),
    this.validator,
    this.readOnly = false,
  }) : super(
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: readOnly,
          typeInput: TypeInput.Numeric,
        );
}

class CountryElement extends TextElement {
  final String initValue;
  final String label;
  final String errorMsg;
  final String labelModalSheet;
  final String labelSearchModalSheet;
  final CountryTextResult countryTextResult;
  final bool showFlag;
  final EdgeInsets padding;

  CountryElement({
    this.initValue,
    this.label,
    this.errorMsg = "invalid Country",
    this.labelModalSheet,
    this.labelSearchModalSheet,
    this.countryTextResult = CountryTextResult.FullName,
    this.showFlag = false,
    this.padding = const EdgeInsets.all(2.0),
  })  : assert((countryTextResult == CountryTextResult.countryCode &&
                (initValue.isEmpty || initValue.length == 3)) ||
            (countryTextResult == CountryTextResult.FullName)),
        super(
          initValue: initValue,
          label: label,
          readOnly: true,
          padding: padding,
          error: errorMsg,
        );
}
