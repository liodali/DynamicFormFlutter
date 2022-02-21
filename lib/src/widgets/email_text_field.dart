import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final EmailElement? emailElement;
  final TextEditingController? textEditingController;
  final InputDecoration? inputDecoration;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;

  EmailTextField({
    this.emailElement,
    this.textEditingController,
    this.errorNotifier,
    this.inputDecoration,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    this.textEditingController!.text = emailElement!.initValue!;
    if (errorNotifier != null) {
      return ValueListenableBuilder<String?>(
          valueListenable: errorNotifier!,
          builder: (ctx, error, _) {
            return TextFormField(
              controller: textEditingController,
              validator: emailElement!.validator,
              readOnly: emailElement!.readOnly,
              keyboardType: Constants.getInput(emailElement!.typeInput),
              style: emailElement!.decorationElement.style,
              focusNode: currentFocus,
              textInputAction: nextFocus == null ? TextInputAction.done : TextInputAction.next,
              onFieldSubmitted: (v) {
                Constants.fieldFocusChange(context, currentFocus, nextFocus);
              },
              decoration: inputDecoration!.copyWith(
                hintText: emailElement!.hint,
                labelText: emailElement!.label,
                errorText: error,
              ),
            );
          });
    }
    return TextFormField(
      controller: textEditingController,
      validator: emailElement!.validator,
      readOnly: emailElement!.readOnly,
      keyboardType: Constants.getInput(emailElement!.typeInput),
      style: emailElement!.decorationElement.style,
      focusNode: currentFocus,
      textInputAction: nextFocus == null ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: (v) {
        Constants.fieldFocusChange(context, currentFocus, nextFocus);
      },
      decoration: inputDecoration!.copyWith(
        hintText: emailElement!.hint,
        labelText: emailElement!.label,
      ),
    );
  }
}
