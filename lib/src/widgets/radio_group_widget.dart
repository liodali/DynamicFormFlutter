import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';

import '../elements/element.dart';

class RadioGroupWidget extends StatelessWidget {
  final RadioGroupElement element;
  final TextEditingController textController;

  const RadioGroupWidget({
    Key? key,
    required this.element,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupController controller = GroupController(
      isMultipleSelection: false,
      initSelectedItem: element.initValue != null ? [element.initValue] : [],
    );
    return SimpleGroupedCheckbox(
      controller: controller,
      itemsTitle: element.valuesLabel,
      values: element.values,
      groupTitle: element.label,
      groupTitleAlignment: element.labelAlignment ?? Alignment.centerLeft,
      groupStyle: GroupStyle(
        activeColor: element.activeSelectedColor,
      ),
      onItemSelected: (selection) {
        if (element.onSelected != null) {
          element.onSelected!(selection as String);
        }
        textController.text = selection;
      },
    );
  }
}
