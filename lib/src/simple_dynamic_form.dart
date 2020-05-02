import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/country_text_field.dart';
import 'package:dynamic_form/src/element.dart';
import 'package:dynamic_form/src/email_text_field.dart';
import 'package:dynamic_form/src/group_elements.dart';
import 'package:dynamic_form/src/password_text_field.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleDynamicForm extends StatefulWidget {
  final List<GroupElement> groupElements;
  final EdgeInsets padding;

  SimpleDynamicForm({
    Key key,
    @required this.groupElements,
    this.padding,
  })  : assert(groupElements.isNotEmpty, "you cannot generate empty form"),
        super(key: key);

  static SimpleDynamicFormState of(BuildContext context,
      {bool nullOk = false}) {
    assert(context != null);
    assert(nullOk != null);
    final SimpleDynamicFormState result =
        context.findAncestorStateOfType<SimpleDynamicFormState>();
    if (nullOk || result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          'SimpleDynamicForm.of() called with a context that does not contain an SimpleDynamicForm.'),
      ErrorDescription(
          'No SimpleDynamicForm ancestor could be found starting from the context that was passed to SimpleDynamicForm.of().'),
      context.describeElement('The context used was')
    ]);
  }

  @override
  State<StatefulWidget> createState() {
    return SimpleDynamicFormState();
  }
}

class SimpleDynamicFormState extends State<SimpleDynamicForm> {
  GlobalKey<FormState> _formKey;
  List<List<TextEditingController>> _listGTextControler;

  recuperateAllValues() {
    List<String> values = [];
    _listGTextControler.forEach((textControllers) {
      textControllers.forEach((controller) {
        values.add(controller.text);
      });
    });
    return values;
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _listGTextControler = [];
    widget.groupElements.forEach((g) {
      List<TextEditingController> _list = [];
      g.textElements.forEach((e) {
        _list.add(TextEditingController(text: e.initValue));
      });
      _listGTextControler.add(_list);
    });
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(5.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            for (GroupElement gelement in widget.groupElements) ...[
              if (gelement.directionGroup == DirectionGroup.Horizontal) ...[
                Container(
                  padding: gelement.padding ?? EdgeInsets.all(2.0),
                  margin: gelement.margin ?? EdgeInsets.all(2.0),
                  color: gelement.backgroundColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      for (var element in gelement.textElements) ...[
                        Flexible(
                          flex: getFlex(gelement.textElements, element,
                              gelement.sizeElements),
                          child: Padding(
                            padding: element.padding,
                            child: generateTextField(
                              element,
                              gelement,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              if (gelement.directionGroup == DirectionGroup.Vertical) ...[
                Container(
                  padding: gelement.padding ?? EdgeInsets.all(2.0),
                  margin: gelement.margin ?? EdgeInsets.all(2.0),
                  color: gelement.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      for (var element in gelement.textElements) ...[
                        Padding(
                          padding: element.padding,
                          child: generateTextField(element, gelement),
                        ),
                      ],
                    ],
                  ),
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }

  int getFlex(
      List<TextElement> textElements, element, List<double> sizeElements) {
    int flex = 0;
    if (textElements.indexOf(element) < sizeElements.length)
      flex = (sizeElements[textElements.indexOf(element)] * 10).toInt();
    else {
      flex = ((1 - sizeElements.reduce((a, b) => a + b)) * 10).toInt();
    }
    return flex;
  }

  Widget generateTextField(TextElement element, GroupElement gElement) {
    var controller = _listGTextControler[widget.groupElements.indexOf(gElement)]
        [gElement.textElements.indexOf(element)];
    if (element.initValue != null && element.initValue.isNotEmpty) {
      controller.text = element.initValue;
    }
    if (element is PasswordElement) {
      return PasswordTextField(
        textEditingController: controller,
        element: element,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement),
        textInputType: Constants.getInput(element.typeInput),
      );
    } else if (element is NumberElement) {
      return TextFormField(
        controller: controller,
        validator: element.validator,
        style: element.decorationElement?.style,
        inputFormatters:
            element.isDigits ? [WhitelistingTextInputFormatter.digitsOnly] : [],
        keyboardType: Constants.getInput(element.typeInput),
        readOnly: element.readOnly,
        decoration: Constants.setInputBorder(context, element.decorationElement)
            .copyWith(
          labelText: element.label,
          hintText: element.hint,
        ),
      );
    } else if (element is CountryElement) {
      return CountryTextField(
        textEditingController: controller,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement)
                .copyWith(
          labelText: element.label,
          labelStyle: TextStyle(color: Colors.black),
          hintText: element.hint,
        ),
        label: element.label,
        errorMsg: element.errorMsg,
        labelModalSheet: element.labelModalSheet,
        labelSearchModalSheet: element.labelSearchModalSheet,
        initValue: element.initValue,
        countryTextResult: element.countryTextResult,
        showFlag: element.showFlag,
      );
    } else if (element is EmailElement) {
      return EmailTextField(
        textEditingController: controller,
        emailElement: element,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement),
      );
    }

    return TextFormField(
      controller: controller,
      validator: element.validator,
      keyboardType: Constants.getInput(element.typeInput),
      readOnly: element.readOnly,
      enabled: true,
      onTap: element.onTap,
      decoration:
          Constants.setInputBorder(context, element.decorationElement).copyWith(
        labelText: element.label,
        hintText: element.hint,
        enabled: true,
        suffixIcon: null,
      ),
    );
  }
}
