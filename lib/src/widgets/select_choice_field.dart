import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class SelectChoiceField extends StatefulWidget {
  final TextEditingController textEditingController;
  final SelectChoiceElement element;
  final InputDecoration? inputDecoration;

  const SelectChoiceField({
    Key? key,
    required this.textEditingController,
    required this.element,
    this.inputDecoration,
  }) : super(key: key);

  @override
  _SelectChoiceFieldState createState() => _SelectChoiceFieldState();
}

class _SelectChoiceFieldState extends State<SelectChoiceField> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.textEditingController.text.isEmpty ? widget.element.initValue : widget.textEditingController.text,
      elevation: 16,
      style: widget.element.decorationElement?.style,
      hint: widget.element.hint != null
          ? Text(
              widget.element.hint!,
            )
          : null,
      onChanged: (String? newValue) {
        setState(() {
          widget.textEditingController.text = newValue!;
        });
      },
      items: widget.element.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: widget.inputDecoration,
    );
  }
}
