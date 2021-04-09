import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CvvTextField extends StatelessWidget {
  final TextEditingController controller;
  final CVVElement element;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;

  CvvTextField({
    required this.controller,
    required this.element,
    this.currentFocus,
    this.nextFocus,
    this.errorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element.initValue != null && element.initValue!.isNotEmpty)
      controller.text = element.initValue!;
    if (errorNotifier != null) {
      return ValueListenableBuilder<String?>(
        valueListenable: errorNotifier!,
        builder: (ctx, error, _) {
          return TextFormField(
            controller: controller,
            maxLength: 3,
            buildCounter: buildCounter,
            validator: element.validator,
            keyboardType: Constants.getInput(element.typeInput),
            readOnly: element.readOnly,
            enabled: true,
            onTap: element.onTap as void Function()?,
            focusNode: currentFocus,
            obscureText: true,
            textInputAction:
                nextFocus == null ? TextInputAction.done : TextInputAction.next,
            onFieldSubmitted: (v) {
              Constants.fieldFocusChange(context, currentFocus, nextFocus);
            },
            decoration:
                Constants.setInputBorder(context, element.decorationElement)
                    .copyWith(
              labelText: element.label,
              hintText: element.hint,
              errorText: error,
              enabled: true,
              suffixIcon: null,
            ),
          );
        },
      );
    }
    return TextFormField(
      controller: controller,
      maxLength: 3,
      buildCounter: buildCounter,
      validator: element.validator,
      keyboardType: Constants.getInput(element.typeInput),
      readOnly: element.readOnly,
      enabled: true,
      onTap: element.onTap as void Function()?,
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
