import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final InputDecoration inputDecoration;
  final Function(String) validator;
  final TextInputType textInputType;
  final TextElement textElement;
  final bool isEnabledToShowPassword;

  PasswordTextField({
    this.textEditingController,
    this.inputDecoration,
    this.isEnabledToShowPassword,
    this.validator,
    this.textInputType,
    this.textElement,
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
      validator: widget.validator,
      keyboardType: widget.textInputType,
      readOnly: widget.textElement.readOnly,
      obscureText: isObscure,
      decoration: widget.inputDecoration.copyWith(
        labelText: widget.textElement.label,
        hintText: widget.textElement.hint,
        suffixIcon: widget.isEnabledToShowPassword
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
