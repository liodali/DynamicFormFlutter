import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CvvTextField extends StatelessWidget {
  final TextEditingController controller;
  final CVVElement element;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  CvvTextField({
    this.controller,
    this.element,
    this.currentFocus,
    this.nextFocus,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element.initValue.isNotEmpty) controller.text = element.initValue;
    return TextFormField(
      controller: controller,
      validator: element.validator,
      keyboardType: Constants.getInput(element.typeInput),
      readOnly: element.readOnly,
      enabled: true,
      onTap: element.onTap,
      focusNode: currentFocus,
      obscureText: true,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: (v) {
        Constants.fieldFocusChange(context, currentFocus, nextFocus);
      },
      decoration:
          Constants.setInputBorder(context, element.decorationElement).copyWith(
        labelText: element.label,
        hintText: element.hint,
        enabled: true,
        suffixIcon: null,
      ),
    );
  }
}
