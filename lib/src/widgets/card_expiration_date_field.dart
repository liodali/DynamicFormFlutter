import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class CardExpirationDateField extends StatelessWidget {
  final CardExpirationDateInputElement element;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String>? errorNotifier;

  CardExpirationDateField({
    required this.element,
    required this.controller,
    this.currentFocus,
    this.nextFocus,
    this.errorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(element.label!=null)...[

        ],
        Row(
          children: [
            TextFormField(),
            TextFormField(),
          ],
        )
      ],
    );
  }
}
