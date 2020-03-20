import 'package:flutter/material.dart';

enum TypeInput { Text, Email, Password, Phone, Numeric, Address }

typedef validation = String Function(String);

@immutable
class TextElement {
  final TypeInput typeInput;
  final String label;
  final String hint;
  final String error;
  final validation validator;
  final EdgeInsets padding;
  TextElement({
    this.typeInput = TypeInput.Text,
    this.label = "",
    this.hint = "",
    this.error = "",
    this.validator,
    this.padding = const EdgeInsets.all(2.0)
  });
}
