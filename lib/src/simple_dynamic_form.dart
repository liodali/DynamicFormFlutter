import 'package:dynamic_form/src/country_text_field.dart';
import 'package:dynamic_form/src/element.dart';
import 'package:dynamic_form/src/group_elements.dart';
import 'package:dynamic_form/src/password_text_field.dart';
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
                          child: generateTextField(
                            element,
                            gelement,
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
                        generateTextField(element, gelement),
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
    if(element.initValue!=null && element.initValue.isNotEmpty){
      controller.text=element.initValue;
    }
    print(element.runtimeType);
    if (element is PasswordElement) {
      return Padding(
        padding: element.padding,
        child: PasswordTextField(
          textEditingController: controller,
          validator: element.validator,
          isEnabledToShowPassword: element.enableShowPassword,
          textElement: element,
          textInputType: getInput(element.typeInput),
        ),
      );
    } else if (element is NumberElement) {
      return Padding(
        padding: element.padding,
        child: TextFormField(
          controller: controller,
          validator: element.validator,
          inputFormatters: element.isDigits
              ? [WhitelistingTextInputFormatter.digitsOnly]
              : [],
          keyboardType: getInput(element.typeInput),
          readOnly: element.readOnly,
          decoration: InputDecoration(
            labelText: element.label,
            hintText: element.hint,
            suffixIcon: null,
          ),
        ),
      );
    } else if (element is CountryElement) {
      return Padding(
        padding: element.padding,
        child: CountryTextField(
          textEditingController: controller,
          label: element.label,
          labelModalSheet: element.labelModalSheet,
          labelSearchModalSheet: element.labelSearchModalSheet,
          initValue: element.initValue,
          countryTextResult: element.countryTextResult,
          showFlag: element.showFlag,
        ),
      );
    }

    return Padding(
      padding: element.padding,
      child: TextFormField(
        controller: controller,
        validator: element.validator,
        keyboardType: getInput(element.typeInput),
        readOnly: element.readOnly,
        enabled: true,
        onTap: element.onTap,
        decoration: InputDecoration(
          labelText: element.label,
          hintText: element.hint,
          enabled: true,
          suffixIcon: null,
        ),
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
      default:
        return TextInputType.text;
        break;
    }
  }
}
