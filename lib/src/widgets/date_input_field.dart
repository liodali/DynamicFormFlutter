import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/constants.dart';
import '../utilities/text_controller_format_input.dart';

class DateInputField extends StatelessWidget {
  final DateInputElement element;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;

  DateInputField({
    required this.element,
    required this.controller,
    this.currentFocus,
    this.nextFocus,
    this.errorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element.initValue != null) {
      controller.text = element.dateFormat?.format(element.initDate!) ?? "";
    }
    final TextControllerFormatInput inputController = TextControllerFormatInput(
        mask: element.dateFormat!.pattern,
        text: controller.text,
        translator: {
          "M": RegExp(r'[0-9]'),
          "y": RegExp(r'[0-9]'),
          "d": RegExp(r'[0-9]'),
          "h": RegExp(r'[0-9]'),
          "m": RegExp(r'[0-9]'),
          "s": RegExp(r'[0-9]'),
        });
    inputController.addListener(() {
      controller.text = inputController.text;
    });
    if (errorNotifier != null) {
      return ValueListenableBuilder<String?>(
        valueListenable: errorNotifier!,
        builder: (ctx, error, _) {
          return TextFormField(
            controller: inputController,
            keyboardType: TextInputType.datetime,
            focusNode: currentFocus,
            inputFormatters: element.formatters,
            textInputAction:
            nextFocus == null ? TextInputAction.done : TextInputAction.next,
            decoration:
            Constants.setInputBorder(context, element.decorationElement)
                .copyWith(
              labelStyle: element.textStyle ??
                  Theme
                      .of(context)
                      .inputDecorationTheme
                      .labelStyle,
              errorStyle: element.errorStyle ??
                  Theme
                      .of(context)
                      .inputDecorationTheme
                      .labelStyle,
              hintText: element.hint,
              labelText: element.label,
            ),
            validator: element.validator,
          );
        },
      );
    }
    return TextFormField(
      controller: inputController,
      keyboardType: TextInputType.datetime,
      focusNode: currentFocus,
      inputFormatters: element.formatters,
      textInputAction:
      nextFocus == null ? TextInputAction.done : TextInputAction.next,
      decoration:
      Constants.setInputBorder(context, element.decorationElement).copyWith(
        labelStyle: element.textStyle ??
            Theme
                .of(context)
                .inputDecorationTheme
                .labelStyle,
        errorStyle: element.errorStyle ??
            Theme
                .of(context)
                .inputDecorationTheme
                .labelStyle,
        hintText: element.hint,
        labelText: element.label,
      ),
      validator: element.validator,
      /* onChanged: (v) {
        controller.text = v;
      },*/
    );
  }
}
