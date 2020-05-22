import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatefulWidget {

  final PhoneNumberElement element;
  final TextEditingController controller;
  PhoneTextField({this.element,this.controller});

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: widget.controller,
    );
  }
}