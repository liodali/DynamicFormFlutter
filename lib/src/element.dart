import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address }

typedef validation = String Function(String);

@immutable
class TextElement {
  final TypeInput typeInput;
  final String label;
  final String hint;
  final String error;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final validation validator;
  final EdgeInsets padding;
  final bool readOnly;

  TextElement({
    this.typeInput = TypeInput.Text,
    this.label = "",
    this.hint = "",
    this.error = "",
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.validator,
    this.readOnly = false,
    this.padding = const EdgeInsets.all(2.0),
  });
}

class EmailElement extends TextElement {
  final String label;
  final String hint;
  final String errorMsg;

  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool readOnly;
  //final List<String> suffix;
  EmailElement({
    this.label,
    this.hint="example@mail.com",
    this.errorMsg,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.readOnly,
  }) : super(
          label: label,
          hint: hint,
          readOnly:readOnly,
          validator: (email) {
            if(email.isNotEmpty){
              bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email);
              if (!emailValid) {
                return errorMsg;
              }
            }else{
              return errorMsg;
            }
            return null;
          },
        );
}
