import 'package:dynamicform/src/element.dart';
import 'package:dynamicform/src/group_elements.dart';
import 'package:flutter/material.dart';

class SimpleDynamicForm extends StatefulWidget {
  final List<GroupElement> groupElements;

  SimpleDynamicForm({@required this.groupElements});

  @override
  State<StatefulWidget> createState() {
    return SimpleDynamicFormState();
  }
}

class SimpleDynamicFormState extends State<SimpleDynamicForm> {
  GlobalKey _formKey;
  List<List<TextEditingController>> _listGTextControler;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _listGTextControler = [];
    widget.groupElements.forEach((g) {
      List<TextEditingController> _list = [];
      g.textElements.forEach((e) {
        _list.add(TextEditingController());
      });
      _listGTextControler.add(_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          for (var gelement in widget.groupElements) ...[
            if (gelement.directionGroup == DirectionGroup.Horizontal) ...[
              Table(
                columnWidths: {
                  for (var v in gelement.sizeElements)
                    gelement.sizeElements.indexOf(v):
                        FixedColumnWidth(v.toDouble())
                },
                children: [
                  TableRow(
                    children: [
                      for (var element in gelement.textElements) ...[
                        generateTextField(element, gelement),
                      ],
                    ],
                  ),
                ],
              ),
            ],
            if (gelement.directionGroup == DirectionGroup.Vertical) ...[
              for (var element in gelement.textElements) ...[
                generateTextField(element, gelement),
              ],
            ]
          ],
        ],
      ),
    );
  }

  Widget generateTextField(TextElement element, GroupElement gelement) {
    return TextFormField(
      controller: _listGTextControler[widget.groupElements.indexOf(gelement)]
          [gelement.textElements.indexOf(element)],
      validator: element.validator,
      keyboardType: getInput(element.typeInput),
      decoration: InputDecoration(
        labelText: element.label,
      ),
    );
  }

  TextInputType getInput(TypeInput typeInput) {
    switch (typeInput) {
      case TypeInput.Email:
        return TextInputType.emailAddress;
        break;
      case TypeInput.Numeric:
        return TextInputType.number;
        break;
      case TypeInput.Address:
        return TextInputType.text;
        break;
      case TypeInput.Text:
      case TypeInput.Password:
        return TextInputType.text;
        break;
      case TypeInput.Phone:
        return TextInputType.phone;
        break;
    }
  }
}
