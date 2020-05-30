import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/decoration_element.dart';
import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address ,multiLine}
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
  final DecorationElement decorationElement;
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
    this.decorationElement = const UnderlineDecorationElement(),
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
  final DecorationElement decorationElement;
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
    this.decorationElement = const UnderlineDecorationElement(),
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
          decorationElement: decorationElement,
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

/// [initValue]: initialized value of  textFormField
/// [label]: label text of  textFormField
/// [hint]: placeholder text of  textFormField
class EmailElement extends TextElement {
  final String initValue;
  final String label;
  final String hint;
  final DecorationElement decorationElement;

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
    this.decorationElement = const UnderlineDecorationElement(),
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
          decorationElement: decorationElement,
          padding: padding,
          readOnly: readOnly,
          validator: (email) {
            if (isRequired) {
              if (email.isEmpty) {
                return errorEmailIsRequired;
              }
            }
            if (email.isNotEmpty) {
              bool emailValid = RegExp(Patterns.emailPattern).hasMatch(email);
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
  final DecorationElement decorationElement;
  final String errorMsg;
  final bool enableShowPassword;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final EdgeInsets padding;
  final bool isRequired;
  final bool hasUppercase;
  final bool hasSpecialCharacter;
  final bool hasDigits;
  final bool readOnly;
  final PasswordError errors;

  //final List<String> suffix;
  PasswordElement({
    this.initValue,
    this.label = " Password ",
    this.hint = "password",
    this.decorationElement = const UnderlineDecorationElement(),
    this.errorMsg,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.enableShowPassword = true,
    this.isRequired,
    int minLength = 6,
    this.hasUppercase,
    this.hasSpecialCharacter,
    this.hasDigits,
    this.errors,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
          initValue: initValue,
          label: label,
          hint: hint,
          onTap: null,
          decorationElement: decorationElement,
          readOnly: readOnly,
          typeInput: TypeInput.Password,
          validator: (password) {
            if (password.isNotEmpty) {
              if (password.length < minLength) {
                return errors.minLengthErrorMsg;
              } else if (RegExp(Patterns.upperAlpha).stringMatch(password) ==
                      null &&
                  hasUppercase) {
                return errors.uppercaseErrorMsg;
              } else if (RegExp(Patterns.specialChar).stringMatch(password) ==
                      null &&
                  hasSpecialCharacter) {
                return errors.specialCharacterErrorMsg;
              } else if (RegExp(Patterns.digitPattern).stringMatch(password) ==
                      null &&
                  hasDigits) {
                return errors.digitsErrorMsg;
              }
            } else if (isRequired) {
              return errors.requiredErrorMsg;
            }
            return null;
          },
        );
}

class NumberElement extends TextElement {
  final String initValue;
  final String label;
  final validation validator;
  final DecorationElement decorationElement;
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
    this.decorationElement = const UnderlineDecorationElement(),
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
          decorationElement: decorationElement,
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: readOnly,
          typeInput: TypeInput.Numeric,
        );
}

class CountryElement extends TextElement {
  final String initValue;
  final DecorationElement decorationElement;
  final String label;
  final String errorMsg;
  final String labelModalSheet;
  final String labelSearchModalSheet;
  final CountryTextResult countryTextResult;
  final bool showFlag;
  final EdgeInsets padding;

  CountryElement({
    this.initValue,
    this.decorationElement = const UnderlineDecorationElement(),
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
          decorationElement: decorationElement,
          label: label,
          readOnly: true,
          padding: padding,
          error: errorMsg,
        );
}

class PhoneNumberElement extends TextElement {
  final String initValue;
  final DecorationElement decorationElement;
  final String label;
  final String hint;
  final String errorMsg;
  final bool showFlag;
  final EdgeInsets padding;
  final validation validator;
  final bool showPrefix;
  final bool readOnly;

  PhoneNumberElement({
    this.initValue = "",
    this.decorationElement = const UnderlineDecorationElement(),
    this.label = "Phone Number",
    this.hint = "(+001)XXXXXXXXX",
    this.errorMsg = "invalid phone number",
    this.validator,
    this.showFlag = false,
    this.readOnly = false,
    this.showPrefix = true,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
            initValue: initValue,
            decorationElement: decorationElement,
            label: label,
            typeInput: TypeInput.Numeric,
            validator: validator ??
                (phone) {
                  if (phone.isEmpty) {
                    return errorMsg;
                  } else if (RegExp(Patterns.phonePattern)
                      .allMatches(phone)
                      .isEmpty) {
                    return errorMsg;
                  }
                  return null;
                },
            hint: hint,
            error: errorMsg,
            padding: padding,
            readOnly: readOnly);
}

class TextAreaElement extends TextElement {
  final int maxLines;
  final bool showCounter;
  final int maxCharacter;

  TextAreaElement({
    String label = "Comment",
    String hint = "Comment",
    validation validator,
    DecorationElement decorationElement=const UnderlineDecorationElement(),
    this.maxLines=3,
    this.showCounter=false,
    this.maxCharacter=250
  }) : super(label: label,hint:hint,decorationElement: decorationElement,validator: validator,typeInput:TypeInput.multiLine);
}

/// [requiredErrorMsg] :  error message to show when textField is Empty
/// [patternErrorMsg] : error message to show when TextField reqExp is not match
/// [error] : general error message
abstract class TextFieldError {
  final String requiredErrorMsg;
  final String patternErrorMsg;
  final String error;

  const TextFieldError({
    this.requiredErrorMsg = "",
    this.patternErrorMsg = "",
    this.error,
  });
}

/// [requiredErrorMsg] :  error message to show when password is Empty
/// [minLengthErrorMsg] : error message to show when password length is less then [minLength]
/// [uppercaseErrorMsg] : error message to show when password doesn't contain uppercase character
/// [specialCharacterErrorMsg] : error message to show when password doesn't contain special character
/// [digitsErrorMsg] : error message to show when password doesn't contain number
/// [error] : generale error message to show
class PasswordError extends TextFieldError {
  final String minLengthErrorMsg;
  final String uppercaseErrorMsg;
  final String specialCharacterErrorMsg;
  final String digitsErrorMsg;

  const PasswordError({
    String requiredErrorMsg = "Password is required",
    this.minLengthErrorMsg = "",
    this.uppercaseErrorMsg =
        "Password must include at least one uppercase letter ",
    this.specialCharacterErrorMsg =
        "Password must include at least one special character",
    this.digitsErrorMsg =
        "Password must include at least one digit from 0 to 9",
    String error,
  }) : super(error: error, requiredErrorMsg: requiredErrorMsg);
}

class EmailError extends TextFieldError {
  EmailError({
    String requiredErrorMsg = "Email is required",
    String patternErrorMsg = "Email is invalid",
    String error,
  }) : super(
          error: error,
          requiredErrorMsg: requiredErrorMsg,
          patternErrorMsg: patternErrorMsg,
        );
}

class UsernameEmailError extends TextFieldError {
  final String patternEmailErrorMsg;
  final String patternUsernameErrorMsg;

  const UsernameEmailError({
    String requiredErrorMsg = "Username or Email is required",
    this.patternEmailErrorMsg = "Email is invalid",
    this.patternUsernameErrorMsg = "Username is invalid",
    String error,
  }) : super(error: error, requiredErrorMsg: requiredErrorMsg);
}
