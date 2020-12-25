import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

import 'utilities/constants.dart';

class DateInputField extends StatelessWidget {
  final DateInputElement element;
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  DateInputField({
    this.element,
    this.controller,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    if (element.initValue != null) {
      controller.text = element.format?.format(element.initDate) ?? "";
    }
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      focusNode: currentFocus,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      decoration:
          Constants.setInputBorder(context, element.decorationElement).copyWith(
        labelStyle: element.textStyle ??
            Theme.of(context).inputDecorationTheme.labelStyle,
        errorStyle: element.errorStyle ??
            Theme.of(context).inputDecorationTheme.labelStyle,
        hintText: element.hint,
        labelText: element.label,
      ),
      validator: element.validator,
    );
  }
}
