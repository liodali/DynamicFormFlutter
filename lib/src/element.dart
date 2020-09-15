import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/decoration_element.dart';
import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address, multiLine }
enum CountryTextResult {
  FullName,
  countryCode,
}

typedef validation = String Function(String);

abstract class FormElement {
  final String id;
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
  final bool visibility;

  FormElement({
    this.id,
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
    this.visibility = true,
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
    String id,
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
    bool visibility = true,
  }) : super(
          id: id,
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
          visibility: visibility,
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
    String id,
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
    bool visibility = true,
  }) : super(
          id: id,
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
          visibility: visibility,
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
    String id,
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
    bool visibility = true,
  }) : super(
          id: id,
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
          visibility: visibility,
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
    String id,
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
    bool visibility = true,
  }) : super(
          id: id,
          decorationElement: decorationElement,
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: readOnly,
          typeInput: TypeInput.Numeric,
          visibility: visibility,
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
    String id,
    this.initValue,
    this.decorationElement = const UnderlineDecorationElement(),
    this.label,
    this.errorMsg = "invalid Country",
    this.labelModalSheet = "Pays",
    this.labelSearchModalSheet = "Recherche",
    this.countryTextResult = CountryTextResult.FullName,
    this.showFlag = false,
    this.padding = const EdgeInsets.all(2.0),
    bool visibility = true,
    bool readOnly = false,
  })  : assert((countryTextResult == CountryTextResult.countryCode &&
                (initValue.isEmpty || initValue.length == 3)) ||
            (countryTextResult == CountryTextResult.FullName)),
        super(
          id: id,
          initValue: initValue,
          decorationElement: decorationElement,
          label: label,
          readOnly: readOnly,
          padding: padding,
          error: errorMsg,
          visibility: visibility,
        );
}

class PhoneNumberElement extends TextElement {
  final String initValue;
  final DecorationElement decorationElement;
  final String label;
  final String hint;
  final String errorMsg;
  final bool showPrefixFlag;
  final bool showSuffixFlag;
  final EdgeInsets padding;
  final validation validator;
  final bool showPrefix;
  final bool readOnly;

  PhoneNumberElement({
    String id,
    this.initValue = "",
    this.decorationElement = const UnderlineDecorationElement(),
    this.label = "Phone Number",
    this.hint = "(+001)XXXXXXXXX",
    this.errorMsg = "invalid phone number",
    this.validator,
    this.showPrefixFlag = false,
    this.showSuffixFlag = false,
    this.readOnly = false,
    this.showPrefix = true,
    this.padding = const EdgeInsets.all(2.0),
    bool visibility = true,
  })  : assert(showPrefixFlag == true && showSuffixFlag == false ||
            showPrefixFlag == false && showSuffixFlag == true ||
            showPrefixFlag == false && showSuffixFlag == false),
        super(
          id: id,
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
          readOnly: readOnly,
          visibility: visibility,
        );
}

class TextAreaElement extends TextElement {
  final int maxLines;
  final bool showCounter;
  final int maxCharacter;

  TextAreaElement({
    String id,
    String label = "Comment",
    String hint = "Comment",
    validation validator,
    DecorationElement decorationElement = const UnderlineDecorationElement(),
    this.maxLines = 3,
    this.showCounter = false,
    this.maxCharacter = 250,
    String messageError = "this field is required",
    bool readOnly = false,
    bool isRequired = false,
    bool visibility = true,
  }) : super(
          label: label,
          hint: hint,
          decorationElement: decorationElement,
          validator: (text) {
            if (isRequired && text.isEmpty) {
              return messageError;
            }
            if (validator != null) return validator(text);

            return null;
          },
          error: messageError,
          typeInput: TypeInput.multiLine,
          readOnly: readOnly,
          visibility: visibility,
        );
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
