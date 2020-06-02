import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final PasswordElement element;
  final InputDecoration inputDecoration;
  final TextInputType textInputType;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  PasswordTextField({
    this.textEditingController,
    this.element,
    this.inputDecoration,
    this.textInputType,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.element.validator,
      keyboardType: widget.textInputType,
      readOnly: widget.element.readOnly,
      obscureText: isObscure,
      focusNode: widget.currentFocus,
      style: widget.element.decorationElement?.style,
      textInputAction: widget.nextFocus == null
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: (v) {
        Constants.fieldFocusChange(
            context, widget.currentFocus, widget.nextFocus);
      },
      decoration: widget.inputDecoration.copyWith(
        labelText: widget.element.label,
        hintText: widget.element.hint,
        suffixIcon: widget.element.enableShowPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.remove_red_eye : Icons.visibility_off,
                  color: Colors.black,
                  size: 16,
                ),
              )
            : false,
      ),
    );
  }
}
