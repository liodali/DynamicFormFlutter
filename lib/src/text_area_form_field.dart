import 'package:dynamic_form/src/element.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAreaFormField extends StatefulWidget {
  final TextAreaElement element;
  final TextEditingController controller;

  TextAreaFormField({Key key, this.element, this.controller}) : super(key: key);

  @override
  _TextAreaFormFieldState createState() => _TextAreaFormFieldState();
}

class _TextAreaFormFieldState extends State<TextAreaFormField> {
  int character=0;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: Constants.getInput(widget.element.typeInput),
      textInputAction: TextInputAction.newline,
      validator: widget.element.validator,
      maxLines: widget.element.maxLines,

      inputFormatters: widget.element.maxCharacter != null &&
          widget.element.maxCharacter != 0 ? [
        LengthLimitingTextInputFormatter(widget.element.maxCharacter),
      ] : [],
      onChanged: (text){
        setState(() {
          character=text.length;
        });
      },
      decoration:
      Constants.setInputBorder(context, widget.element.decorationElement)
          .copyWith(
          labelText: widget.element.label,
          hintText: widget.element.hint,
          enabled: true,
          counterText: widget.element.showCounter?"$character/${widget.element.maxCharacter}":"",
      ),
    );
  }
}
