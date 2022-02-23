import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final PasswordElement? element;
  final InputDecoration? inputDecoration;
  final TextInputType? textInputType;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;

  PasswordTextField({
    this.textEditingController,
    this.element,
    this.errorNotifier,
    this.inputDecoration,
    this.textInputType,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late ValueNotifier<bool> isObscureNotifier;

  @override
  void initState() {
    super.initState();
    isObscureNotifier = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isObscureNotifier,
      builder: (ctx, isObscure, child) {
        final suffixWidget = isObscure
            ? widget.element!.decorationPasswordElement?.showPasswordWidget
            : widget.element!.decorationPasswordElement?.hidePasswordWidget ?? null;
        if (widget.errorNotifier != null) {
          return ValueListenableBuilder<String?>(
            valueListenable: widget.errorNotifier!,
            builder: (ctx, error, _) {
              return TextFormField(
                controller: widget.textEditingController,
                validator: widget.element!.validator,
                keyboardType: widget.textInputType,
                readOnly: widget.element!.readOnly,
                obscureText: isObscure,
                focusNode: widget.currentFocus,
                style: widget.element!.decorationPasswordElement?.style,
                maxLines: 1,
                textInputAction:
                    widget.nextFocus == null ? TextInputAction.done : TextInputAction.next,
                onFieldSubmitted: (v) {
                  Constants.fieldFocusChange(context, widget.currentFocus, widget.nextFocus);
                },
                decoration: widget.inputDecoration!.copyWith(
                  labelText: widget.element!.label,
                  hintText: widget.element!.hint,
                  errorText: error,
                  suffixIcon: widget.element!.enableShowPassword
                      ? GestureDetector(
                          onTap: () {
                            isObscureNotifier.value = !isObscure;
                          },
                          child: suffixWidget ??
                              Icon(
                                isObscure ? Icons.remove_red_eye : Icons.visibility_off,
                                color: Colors.black,
                                size: 20,
                              ),
                        )
                      : null,
                ),
              );
            },
          );
        }
        return TextFormField(
          controller: widget.textEditingController,
          validator: widget.element!.validator,
          keyboardType: widget.textInputType,
          readOnly: widget.element!.readOnly,
          obscureText: isObscure,
          focusNode: widget.currentFocus,
          style: widget.element!.decorationPasswordElement?.style,
          maxLines: 1,
          textInputAction: widget.nextFocus == null ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: (v) {
            Constants.fieldFocusChange(context, widget.currentFocus, widget.nextFocus);
          },
          decoration: widget.inputDecoration!.copyWith(
            labelText: widget.element!.label,
            hintText: widget.element!.hint,
            suffix: widget.element!.enableShowPassword
                ? GestureDetector(
                    onTap: () {
                      isObscureNotifier.value = !isObscure;
                    },
                    child: suffixWidget ??
                        Icon(
                          isObscure ? Icons.remove_red_eye : Icons.visibility_off,
                          color: Colors.black,
                          size: 24,
                        ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
