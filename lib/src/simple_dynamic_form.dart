import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './elements/element.dart';
import './elements/group_elements.dart';
import './utilities/constants.dart';
import './widgets/card_number_field.dart';
import './widgets/country_text_field.dart';
import './widgets/cvv_text_field.dart';
import './widgets/date_input_field.dart';
import './widgets/date_text_field.dart';
import './widgets/email_text_field.dart';
import './widgets/password_text_field.dart';
import './widgets/phone_text_field.dart';
import './widgets/text_area_form_field.dart';

///  [padding]          : The amount of space by which to inset the form.                                                                          |
///  [groupElements]    :  list of element to build your form.                                                          |
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
  Map<String, TextEditingController> mapGtextControler;
  List<List<FocusNode>> focusList;

  List<String> recuperateAllValues() {
    List<String> values = [];
    _listGTextControler.forEach((textControllers) {
      textControllers.forEach((controller) {
        values.add(controller.text);
      });
    });
    return values;
  }

  void clearValues() {
    _listGTextControler.forEach((textControllers) {
      textControllers.forEach((controller) {
        controller.clear();
      });
    });
  }

  Map<String, String> recuperateByIds() {
    Map<String, String> values = {};
    mapGtextControler.forEach((key, value) {
      values.putIfAbsent(key, () => value.text);
    });
    return values;
  }

  String singleValueById(String id) {
    if (mapGtextControler.containsKey(id)) {
      return mapGtextControler[id].text;
    } else {
      throw (Exception("id doesn't exist"));
    }
  }

  @override
  void initState() {
    super.initState();
    var listIds = [];
    widget.groupElements.forEach((e) => e.textElements.forEach((elem) {
          if (listIds.isEmpty || !listIds.contains(elem.id))
            listIds.add(elem.id);
          else {
            if (listIds.contains(elem.id)) {
              assert(true, "duplicated ids");
            }
          }
        }));
    listIds.asMap().forEach((key, value) {});
    _formKey = GlobalKey<FormState>();
    _listGTextControler = [];
    mapGtextControler = {};
    focusList = [];
    widget.groupElements.forEach((g) {
      List<TextEditingController> _list = [];
      List<FocusNode> _listFocus = [];
      g.textElements.forEach((e) {
        var controllerText = TextEditingController(text: e.initValue);
        _list.add(controllerText);
        if (e.id != null && e.id.isNotEmpty) {
          mapGtextControler.putIfAbsent("${e.id}", () => controllerText);
        }
        _listFocus.add(FocusNode());
      });
      _listGTextControler.add(_list);
      focusList.add(_listFocus);
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
                        Visibility(
                          visible: element.visibility,
                          child: Flexible(
                            flex: getFlex(gelement.textElements, element,
                                gelement.sizeElements),
                            child: Padding(
                              padding: element.padding,
                              child: _GenerateTextField(
                                element: element,
                                gElement: gelement,
                                groupElements: widget.groupElements,
                                controllers: _listGTextControler,
                                focusList: focusList,
                                textElements: gelement.textElements,
                              ),
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
                        Visibility(
                          visible: element.visibility,
                          child: Padding(
                            padding: element.padding,
                            child: _GenerateTextField(
                              element: element,
                              gElement: gelement,
                              groupElements: widget.groupElements,
                              controllers: _listGTextControler,
                              focusList: focusList,
                              textElements: gelement.textElements,
                            ),
                          ),
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
}

class _GenerateTextField extends StatelessWidget {
  final GroupElement gElement;
  final List<GroupElement> groupElements;
  final TextElement element;
  final List<TextElement> textElements;
  final List<List<TextEditingController>> controllers;
  final List<List<FocusNode>> focusList;

  _GenerateTextField({
    this.element,
    this.gElement,
    this.groupElements,
    this.textElements,
    this.controllers,
    this.focusList,
  });

  @override
  Widget build(BuildContext context) {
    int gIndex = groupElements.indexOf(gElement);
    int eIndex = gElement.textElements.indexOf(element);
    var controller = controllers[gIndex][eIndex];

    var focusNodeNext = focusList[gIndex].length > (eIndex + 1)
        ? focusList[gIndex][eIndex + 1]
        : focusList.length > gIndex + 1
            ? focusList[gIndex + 1].first
            : null;

    var focusNodeCurrent = focusList[gIndex].length > (eIndex)
        ? focusList[gIndex][eIndex]
        : focusList.length > gIndex
            ? focusList[gIndex].first
            : null;

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
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is CardNumberElement) {
      return CardNumberField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element,
      );
    } else if (element is CVVElement) {
      return CvvTextField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element,
      );
    } else if (element is NumberElement) {
      return TextFormField(
        controller: controller,
        validator: element.validator,
        style: element.decorationElement?.style,
        focusNode: focusNodeCurrent,
        inputFormatters: (element as NumberElement).isDigits
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        keyboardType: Constants.getInput(element.typeInput),
        readOnly: element.readOnly,
        textInputAction:
            focusNodeNext == null ? TextInputAction.done : TextInputAction.next,
        onFieldSubmitted: (v) {
          Constants.fieldFocusChange(context, focusNodeCurrent, focusNodeNext);
        },
        decoration: Constants.setInputBorder(context, element.decorationElement)
            .copyWith(
          labelText: element.label,
          hintText: element.hint,
        ),
      );
    } else if (element is CountryElement) {
      return CountryTextField(
        textEditingController: controller,
        element: element,
      );
    } else if (element is EmailElement) {
      return EmailTextField(
        textEditingController: controller,
        emailElement: element,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement),
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is PhoneNumberElement) {
      return PhoneTextField(
        controller: controller,
        element: element,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is TextAreaElement) {
      return TextAreaFormField(
        element: element,
        controller: controller,
      );
    } else if (element is DateElement) {
      return DateTextField(
        controller: controller,
        element: element,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is DateInputElement) {
      return DateInputField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element,
      );
    }

    return TextFormField(
      controller: controller,
      validator: element.isRequired
          ? (v) {
              if (v.isEmpty) {
                return element.error;
              }
              if (element?.validator != null) return element?.validator(v);
              return null;
            }
          : element.validator,
      keyboardType: Constants.getInput(element.typeInput),
      readOnly: element.readOnly,
      enabled: true,
      onTap: element.onTap,
      focusNode: focusNodeCurrent,
      textInputAction:
          focusNodeNext == null ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: (v) {
        Constants.fieldFocusChange(context, focusNodeCurrent, focusNodeNext);
      },
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
