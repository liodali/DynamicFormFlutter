import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class DateTextField extends StatelessWidget {
  final DateElement element;
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final dateFormat = DateFormat.yMEd();

  DateTextField({
    this.element,
    this.controller,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: element.readOnly,
      keyboardType: Constants.getInput(element.typeInput),
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
        suffixIcon: element.suffixIcon,
      ),
      validator: (v) {
        if (element.isRequired) {
          if (v.isEmpty || v == null) {
            return element.errorMsg;
          }
        }

        return null;
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime date = await showDatePicker(
          context: context,
          initialDate: element.initDate ?? DateTime.now(),
          firstDate: element.firstDate ?? DateTime(1970, 1, 1),
          lastDate: element.lastDate ?? DateTime(2100, 12, 31),
          selectableDayPredicate: element.selectableDayPredicate,
        );
        if (date == null) {
          controller.text = "";
        } else {
          controller.text =
              element.format?.format(date) ?? dateFormat.format(date);
        }
        Constants.fieldFocusChange(context, currentFocus, nextFocus);
      },
    );
  }
}
