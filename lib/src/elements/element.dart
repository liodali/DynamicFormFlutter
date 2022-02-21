import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../utilities/patterns.dart';
import 'decoration_element.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address, multiLine }
enum CountryTextResult {
  FullName,
  countryCode,
}
enum DateExpirationEntryMode {
  /// dropdown for month input and year input.
  dropdown,

  /// Text input.
  input,
}

typedef Validation = String? Function(String?);

abstract class FormElement {
  final String? id;
  final TypeInput? typeInput;
  final String? initValue;
  final String? label;
  final String? hint;
  final String? error;
  final DecorationElement? decorationElement;
  final bool? readOnly;
  final bool visibility;

  FormElement({
    this.id,
    this.typeInput,
    this.initValue = "",
    this.label = "",
    this.hint = "",
    this.error = "",
    this.decorationElement = const UnderlineDecorationElement(),
    this.readOnly,
    this.visibility = true,
  });
}

///[TextElement] : base blueprint for TextFormField
///
///
///
///
///
///
///
///
class TextElement extends FormElement {
  final TypeInput typeInput;
  final String? initValue;
  final Function? onTap;
  final DecorationElement? decorationElement;
  final String? label;
  final String? hint;
  final String? error;
  final Validation? validator;
  final EdgeInsets padding;
  final bool? isRequired;
  final bool readOnly;

  TextElement({
    String? id,
    this.typeInput = TypeInput.Text,
    this.initValue,
    this.onTap,
    this.decorationElement = const UnderlineDecorationElement(),
    this.label = "",
    this.hint = "",
    this.error = "",
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
          readOnly: readOnly,
          visibility: visibility,
        );
}

/// [EmailElement] : representation of  email text field in form
///
/// [initValue] : initialized value of  textFormField
///
/// [label] : label text of  textFormField
///
/// [hint] : placeholder text of  textFormField
///
/// [decorationElement] :  element decorator for text field
///
/// [errorEmailPattern] : (String) error message when email pattern was invalid
///
/// [errorEmailIsRequired] : (String) error message when email was required
///
/// [errorStyle] :
///
/// [hintStyle] :
///
/// [labelStyle] :
///
/// [isRequired] : (bool) make email field required in the form validation
///
/// [readOnly] : (bool) make email text field read only
class EmailElement extends TextElement {
  final String? initValue;
  final String? label;
  final String? hint;
  final DecorationElement decorationElement;

  final String errorEmailPattern;
  final String errorEmailIsRequired;
  final EdgeInsets padding;
  final bool isRequired;
  final bool readOnly;

  //final List<String> suffix;
  EmailElement({
    String? id,
    this.initValue,
    this.label,
    this.hint,
    this.decorationElement = const UnderlineDecorationElement(),
    this.errorEmailPattern = "invalid email",
    this.errorEmailIsRequired = "email is empty",
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
              if (email!.isEmpty) {
                return errorEmailIsRequired;
              }
            }
            if (email!.isNotEmpty) {
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
  final String? initValue;
  final String? label;
  final String? hint;
  final PasswordElementDecoration decorationPasswordElement;
  final String? errorMsg;
  final bool enableShowPassword;
  final EdgeInsets padding;
  final bool? isRequired;
  final bool? hasUppercase;
  final bool? hasSpecialCharacter;
  final bool? hasDigits;
  final bool readOnly;
  final PasswordError? errors;

  //final List<String> suffix;
  PasswordElement({
    String? id,
    this.initValue,
    this.label,
    this.hint,
    this.decorationPasswordElement = const UnderlinePasswordElementDecoration(),
    this.errorMsg,
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
          readOnly: readOnly,
          typeInput: TypeInput.Password,
          validator: (password) {
            if (password != null) {
              if (password.isNotEmpty) {
                if (password.length < minLength) {
                  return errors!.minLengthErrorMsg;
                } else if (RegExp(Patterns.upperAlpha).stringMatch(password) == null &&
                    hasUppercase!) {
                  return errors!.uppercaseErrorMsg;
                } else if (RegExp(Patterns.specialChar).stringMatch(password) == null &&
                    hasSpecialCharacter!) {
                  return errors!.specialCharacterErrorMsg;
                } else if (RegExp(Patterns.digitPattern).stringMatch(password) == null &&
                    hasDigits!) {
                  return errors!.digitsErrorMsg;
                }
              } else if (isRequired!) {
                return errors!.requiredErrorMsg;
              }
            }
            return null;
          },
          visibility: visibility,
        );
}

class NumberElement extends TextElement {
  final String? initValue;
  final String? label;
  final Validation? validator;
  final DecorationElement? decorationElement;
  final String? hint;
  final String? errorMsg;
  final bool isDigits;
  final EdgeInsets padding;
  final bool readOnly;
  final bool isRequired;

  //final List<String> suffix;
  NumberElement({
    String? id,
    this.initValue,
    this.label = "",
    this.hint = "",
    this.decorationElement = const UnderlineDecorationElement(),
    this.isDigits = false,
    this.errorMsg,
    this.padding = const EdgeInsets.all(2.0),
    this.validator,
    this.isRequired = false,
    this.readOnly = false,
    bool visibility = true,
  }) : super(
          id: id,
          decorationElement: decorationElement,
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: readOnly,
          isRequired: isRequired,
          typeInput: TypeInput.Numeric,
          visibility: visibility,
        );
}

class CardNumberElement extends NumberElement {
  final String? initValue;
  final String? label;
  final String errorIsRequiredMessage;
  final DecorationElement? decorationElement;
  final String hint;
  final String? errorMsg;
  final EdgeInsets padding;

  CardNumberElement({
    String? id,
    this.initValue,
    this.label = "Credit Card Number",
    this.hint = "XXXX XXXX XXXX XXXX",
    this.decorationElement = const UnderlineDecorationElement(),
    this.errorMsg,
    this.errorIsRequiredMessage = "this Field is required",
    this.padding = const EdgeInsets.all(2.0),
  }) : super(
          id: id,
          decorationElement: decorationElement,
          initValue: initValue,
          label: label,
          hint: hint,
          readOnly: false,
          visibility: true,
        );
}

class CVVElement extends NumberElement {
  CVVElement({
    String? id,
    String initValue = "",
    String label = "",
    String hint = "",
    decorationElement = const UnderlineDecorationElement(),
    String? error,
    EdgeInsets padding = const EdgeInsets.all(2.0),
    validator,
    bool readOnly = false,
    bool visibility = true,
  }) : super(
          id: id,
          decorationElement: decorationElement,
          initValue: initValue,
          label: label,
          hint: hint,
          padding: padding,
          validator: validator ??
              (v) {
                if (v != null && v.length != 3) {
                  return error;
                }
                return null;
              },
          readOnly: readOnly,
          visibility: visibility,
          isDigits: true,
        );
}

class CountryElement extends TextElement {
  final String? initValue;
  final DecorationElement decorationElement;
  final String? label;
  final String errorMsg;
  final String labelModalSheet;
  final String labelSearchModalSheet;
  final CountryTextResult countryTextResult;
  final bool showFlag;
  final EdgeInsets padding;

  CountryElement({
    String? id,
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
                (initValue!.isEmpty || initValue.length == 3)) ||
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
  final String initPrefix;
  final DecorationElement decorationElement;
  final String label;
  final String hint;
  final String errorMsg;
  final bool showPrefixFlag;
  final bool showSuffixFlag;
  final String labelModalSheet;
  final EdgeInsets padding;
  final Validation? validator;
  final bool showPrefix;
  final bool readOnly;

  PhoneNumberElement({
    String? id,
    this.initValue = "",
    this.decorationElement = const UnderlineDecorationElement(),
    this.label = "Phone Number",
    this.hint = "(+001)XXXXXXXXX",
    this.errorMsg = "invalid phone number",
    this.labelModalSheet = "select calling code",
    this.validator,
    this.showPrefixFlag = false,
    this.showSuffixFlag = false,
    this.readOnly = false,
    this.showPrefix = true,
    this.initPrefix = "",
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
                if (phone != null) {
                  if (phone.isEmpty) {
                    return errorMsg;
                  } else if (RegExp(Patterns.phonePattern).allMatches(phone).isEmpty) {
                    return errorMsg;
                  }
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
    String? id,
    String label = "Comment",
    String hint = "Comment",
    Validation? validator,
    DecorationElement decorationElement = const UnderlineDecorationElement(),
    this.maxLines = 3,
    this.showCounter = false,
    this.maxCharacter = 250,
    String messageError = "this field is required",
    bool readOnly = false,
    bool isRequired = false,
    bool visibility = true,
  }) : super(
          id: id,
          label: label,
          hint: hint,
          decorationElement: decorationElement,
          validator: (text) {
            if (isRequired && text != null && text.isEmpty) {
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

/// blueprint that open date picker to pick your date
///
/// [id] : String,should be unique.
/// [initDate] : (DateTime)  initialize the input field.
/// [firstDate] : (DateTime)  represent earliest allowable Date in date picker.
/// [lastDate] : (DateTime)  represent latest allowable Date in date picker.
/// [format] : (DateFormat)  for format the date  that you pick (default  :DateFormat.yMd()).
/// [selectableDayPredicate] : (SelectableDayPredicate)  to enable dates to be selected.
/// [label] : (String) text label of TextField.
/// [decorationElement] :input decoration of TextField.
/// [hint] : (String) hint text of textField.
/// [isRequired] : (bool) if true,make this field required.
/// [errorMsg] : (String) show error message  when the field isn't validate.
/// [padding] : (EdgeInsets) padding of textField.
class DateElement extends TextElement {
  final String? id;
  final DateTime? initDate;
  final DateFormat? format;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final SelectableDayPredicate? selectableDayPredicate;
  final String? label;
  final DecorationElement? decorationElement;
  final String? hint;
  final bool isRequired;
  final bool readOnly = true;
  final String? errorMsg;
  final EdgeInsets padding;
  final Icon suffixIcon;

  DateElement({
    this.id,
    this.format,
    this.initDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.label,
    this.suffixIcon = const Icon(
      Icons.calendar_today,
      color: Colors.black,
      size: 24,
    ),
    this.decorationElement,
    this.hint,
    this.isRequired = false,
    this.errorMsg,
    this.padding = const EdgeInsets.all(0),
  }) : super(
          id: id,
          padding: padding,
          error: errorMsg,
          isRequired: isRequired,
          hint: hint,
          label: label,
          decorationElement: decorationElement,
          initValue: initDate != null
              ? format != null
                  ? format.format(initDate)
                  : DateFormat.yMd().format(initDate)
              : null,
        );
}

/// blueprint that  date input to date
///
/// [id] : String,should be unique.
/// [initDate] : (DateTime)  initialize the input field.
/// [label] : (String) text label of TextField.
/// [decorationElement] :input decoration of TextField.
/// [hint] : (String) hint text of textField.
/// [isRequired] : (bool) if true,make this field required.
/// [errorMsg] : (String) show error message  when the field isn't validate.
/// [padding] : (EdgeInsets) padding of textField.
class DateInputElement extends TextElement {
  final String? id;
  final DateTime? initDate;
  final DateFormat? dateFormat;
  final String? label;
  final bool? isRequired;
  final DecorationElement? decorationElement;
  final Validation? validator;
  final String? hint;
  final int? minLength;
  final bool readOnly = false;
  final String? errorMsg;
  final String? requiredErrorMsg;
  final EdgeInsets padding;
  final List<TextInputFormatter>? formatters;

  DateInputElement({
    this.id,
    this.dateFormat,
    this.initDate,
    this.label,
    this.minLength,
    this.formatters,
    this.isRequired,
    this.decorationElement,
    this.validator,
    this.hint,
    this.errorMsg,
    this.requiredErrorMsg,
    this.padding = const EdgeInsets.all(0),
  }) : super(
          id: id,
          padding: padding,
          error: errorMsg,
          isRequired: isRequired,
          hint: hint,
          label: label,
          validator: (v) {
            if (isRequired!) {
              return requiredErrorMsg ?? "this field is requied";
            }
            return validator != null ? validator(v) : null;
          },
          decorationElement: decorationElement,
        );
}

/// blueprint for card expiration date input
///
/// [id] : String,should be unique.
///
/// [label] : (String) text label of TextField.
///
/// [isPicker] : (bool) show bottomSheet to select values for inputs.
///
/// [decorationElement] :input decoration of TextField.
///
/// [isRequired] : (bool) if true,make this field required.
///
/// [requiredErrorMsg] : (String) show error message  when the field isn't validate.
///
/// [padding] : (EdgeInsets) padding of textField.
class CardExpirationDateInputElement extends NumberElement {
  final String? id;
  final int? maxYear;
  final String? label;
  final bool isRequired;
  final DecorationElement? decorationElement;
  final DateExpirationEntryMode entryMode;
  final String requiredErrorMsg;
  final String invalidErrorMsg;
  final EdgeInsets padding;

  CardExpirationDateInputElement({
    this.id,
    this.maxYear,
    this.label,
    this.isRequired = true,
    this.entryMode = DateExpirationEntryMode.input,
    this.decorationElement,
    required this.requiredErrorMsg,
    required this.invalidErrorMsg,
    this.padding = const EdgeInsets.all(0),
  })  : assert(requiredErrorMsg.isNotEmpty),
        assert(invalidErrorMsg.isNotEmpty),
        super(
          id: id,
          padding: padding,
          isRequired: isRequired,
          errorMsg: invalidErrorMsg,
          label: label,
          decorationElement: decorationElement,
        ) {
    if (maxYear != null && maxYear! < DateTime.now().year) {
      assert(false);
    }
  }
}

///PasswordControls : validation  rules for password input
///
/// [hasUppercase]: make password contains at least one upperCase character
/// [hasSpecialCharacter]: make password contains at least one special character
/// [hasDigits]: make password contains at least one digits
/// [passwordMinLength]: minimum length accepted by password
class PasswordControls {
  final bool hasUppercase;
  final bool hasSpecialCharacter;
  final bool hasDigits;
  final int passwordMinLength;

  const PasswordControls.only({
    this.hasDigits = true,
    this.hasSpecialCharacter = true,
    this.hasUppercase = true,
    this.passwordMinLength = 6,
  });

  const PasswordControls.strong()
      : this.hasUppercase = true,
        this.hasDigits = true,
        this.hasSpecialCharacter = true,
        this.passwordMinLength = 8;

  const PasswordControls.all(
    bool value, {
    this.passwordMinLength = 6,
  })  : this.hasUppercase = value,
        this.hasDigits = value,
        this.hasSpecialCharacter = value;
}

/// [requiredErrorMsg] :  error message to show when textField is Empty
/// [patternErrorMsg] : error message to show when TextField reqExp is not match
/// [error] : general error message
abstract class TextFieldError {
  final String requiredErrorMsg;
  final String patternErrorMsg;
  final String? error;

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
    this.uppercaseErrorMsg = "Password must include at least one uppercase letter ",
    this.specialCharacterErrorMsg = "Password must include at least one special character",
    this.digitsErrorMsg = "Password must include at least one digit from 0 to 9",
    String? error,
  }) : super(error: error, requiredErrorMsg: requiredErrorMsg);
}

class EmailError extends TextFieldError {
  EmailError({
    String requiredErrorMsg = "Email is required",
    String patternErrorMsg = "Email is invalid",
    String? error,
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
    String? error,
  }) : super(error: error, requiredErrorMsg: requiredErrorMsg);
}
