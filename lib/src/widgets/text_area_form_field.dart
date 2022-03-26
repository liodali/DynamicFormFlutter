import 'package:dynamic_form/src/elements/decoration_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../elements/element.dart';
import '../utilities/constants.dart';

class TextAreaFormField extends StatefulWidget {
  final TextAreaElement element;
  final TextEditingController? controller;
  final DecorationElement? commonDecorationElem;

  TextAreaFormField({
    Key? key,
    required this.element,
    this.controller,
    this.commonDecorationElem,
  }) : super(key: key);

  @override
  _TextAreaFormFieldState createState() => _TextAreaFormFieldState();
}

class _TextAreaFormFieldState extends State<TextAreaFormField> {
  int character = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: Constants.getInput(widget.element.typeInput),
      textInputAction: TextInputAction.newline,
      validator: widget.element.validator,
      minLines: 1,
      maxLines: widget.element.maxLines,
      inputFormatters: widget.element.maxCharacter != 0
          ? [
              LengthLimitingTextInputFormatter(widget.element.maxCharacter),
            ]
          : [],
      onChanged: (text) {
        setState(() {
          character = text.length;
        });
      },
      decoration: Constants.setInputBorder(
        context,
        widget.element.decorationElement,
        common: widget.commonDecorationElem,
      ).copyWith(
        labelText: widget.element.label,
        hintText: widget.element.hint,
        enabled: true,
        counterText: widget.element.showCounter
            ? "$character/${widget.element.maxCharacter}"
            : "",
      ),
    );
  }
}
