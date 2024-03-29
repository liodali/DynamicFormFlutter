import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class DateTextField extends StatelessWidget {
  final DateElement element;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final dateFormat = DateFormat.yMEd();
  final ValueNotifier<String>? errorNotifier;
  final DecorationElement? commonDecorationElem;

  DateTextField(
      {this.errorNotifier,
      required this.element,
      required this.controller,
      this.currentFocus,
      this.nextFocus,
      this.commonDecorationElem});

  @override
  Widget build(BuildContext context) {
    if (errorNotifier == null) {
      return TextFormField(
        controller: controller,
        readOnly: element.readOnly,
        keyboardType: Constants.getInput(element.typeInput),
        focusNode: currentFocus,
        textInputAction:
            nextFocus == null ? TextInputAction.done : TextInputAction.next,
        decoration: Constants.setInputBorder(
          context,
          element.decorationElement,
          common: commonDecorationElem,
        ).copyWith(
          hintText: element.hint,
          labelText: element.label,
          suffixIcon: element.suffixIcon,
        ),
        validator: (v) {
          if (element.isRequired) {
            if (v!.isEmpty) {
              return element.errorMsg;
            }
          }

          return null;
        },
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? date = await showDatePicker(
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
    return ValueListenableBuilder<String>(
      valueListenable: errorNotifier!,
      builder: (ctx, error, _) {
        return TextFormField(
          controller: controller,
          readOnly: element.readOnly,
          keyboardType: Constants.getInput(element.typeInput),
          focusNode: currentFocus,
          textInputAction:
              nextFocus == null ? TextInputAction.done : TextInputAction.next,
          decoration: Constants.setInputBorder(
            context,
            element.decorationElement,
            common: commonDecorationElem,
          ).copyWith(
            hintText: element.hint,
            labelText: element.label,
            suffixIcon: element.suffixIcon,
            errorText: error,
          ),
          validator: (v) {
            if (element.isRequired) {
              if (v!.isEmpty) {
                return element.errorMsg;
              }
            }
            return null;
          },
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            DateTime? date = await showDatePicker(
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
      },
    );
  }
}
