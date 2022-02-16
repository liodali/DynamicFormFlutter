import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './controller/form_controller.dart';
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
import './widgets/card_expiration_date_field.dart';
import './widgets/text_area_form_field.dart';

/// [SimpleDynamicForm]: simple blueprint form generator
///
///  [padding]          : The amount of space by which to inset the form.                                                                          |
///
///  [groupElements]    :  list of element to build your form.                                                          |
class SimpleDynamicForm extends StatefulWidget {
  final List<GroupElement> groupElements;
  final EdgeInsets? padding;
  final FormController controller;
  final Widget? submitButton;

  SimpleDynamicForm({
    Key? key,
    required this.controller,
    required this.groupElements,
    this.submitButton,
    this.padding,
  })  : assert(groupElements.isNotEmpty, "you cannot generate empty form"),
        super(key: key);

  static FormController? of(BuildContext context, {bool nullOk = false}) {
    final SimpleDynamicForm? result =
        context.findAncestorWidgetOfExactType<SimpleDynamicForm>();
    if (nullOk || result != null) return result!.controller;
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
  GlobalKey<FormState>? _formKey;
  late List<List<TextEditingController>> _listGTextController;
  late Map<String, TextEditingController> _mapGTextController;
  late Map<String, ValueNotifier<String?>> _mapValueNotifierErrorField;
  List<List<FocusNode>>? focusList;

  List<String> recuperateAllValues() {
    List<String> values = [];
    _listGTextController.forEach((textControllers) {
      textControllers.forEach((controller) {
        values.add(controller.text);
      });
    });
    return values;
  }

  void clearValues() {
    _listGTextController.asMap().forEach((index, textControllers) {
      textControllers.asMap().forEach((indexController, controller) {
        if (!widget.groupElements[index].textElements[indexController].readOnly)
          controller.clear();
      });
    });
  }

  void clearValueById(String id) {
    if (!widget.groupElements
        .map((g) => g.textElements.firstWhere((e) => e.id == id))
        .first
        .readOnly) _mapGTextController[id]!.clear();
  }

  Map<String, String> recuperateByIds() {
    Map<String, String> values = {};
    _mapGTextController.forEach((key, value) {
      values.putIfAbsent(key, () => value.text);
    });
    return values;
  }

  String singleValueById(String id) {
    assert(_mapGTextController.containsKey(id), "id doesn't exist");
    return _mapGTextController[id]!.text;
  }

  void errorFieldById(String id, String error) {
    assert(_mapValueNotifierErrorField.containsKey(id), "id doesn't exist");
    _mapValueNotifierErrorField[id]!.value = error;
  }

  void clearErrors() {
    _mapValueNotifierErrorField.forEach((key, value) {
      _mapValueNotifierErrorField[key]!.value = null;
    });
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
    _formKey = GlobalKey<FormState>();
    _listGTextController = [];
    _mapGTextController = {};
    _mapValueNotifierErrorField = {};
    focusList = [];
    widget.groupElements.forEach((g) {
      List<TextEditingController> _list = [];
      List<FocusNode> _listFocus = [];
      g.textElements.forEach((e) {
        var controllerText = TextEditingController(text: e.initValue);
        _list.add(controllerText);
        if (e.id != null && e.id!.isNotEmpty) {
          _mapGTextController.putIfAbsent("${e.id}", () => controllerText);
          _mapValueNotifierErrorField.putIfAbsent(
              "${e.id}", () => ValueNotifier(null));
        }
        _listFocus.add(FocusNode());
      });
      _listGTextController.add(_list);
      focusList!.add(_listFocus);
    });
    widget.controller.init(this);
  }

  bool validate() {
    return _formKey!.currentState!.validate();
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
                                errorNotifier: _mapValueNotifierErrorField
                                        .containsKey(element.id)
                                    ? _mapValueNotifierErrorField[element.id!]
                                    : null,
                                element: element,
                                gElement: gelement,
                                groupElements: widget.groupElements,
                                controllers: _listGTextController,
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
                              errorNotifier: _mapValueNotifierErrorField
                                      .containsKey(element.id)
                                  ? _mapValueNotifierErrorField[element.id!]
                                  : null,
                              element: element,
                              gElement: gelement,
                              groupElements: widget.groupElements,
                              controllers: _listGTextController,
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
            if (widget.submitButton != null) ...[
              Builder(
                builder: (context) {
                  return widget.submitButton!;
                },
              )
            ]
          ],
        ),
      ),
    );
  }

  int getFlex(
      List<TextElement?> textElements, element, List<double> sizeElements) {
    int flex = 0;
    if (textElements.indexOf(element) < sizeElements.length)
      flex = (sizeElements[textElements.indexOf(element)] * 10).toInt();
    else {
      flex = ((1 - sizeElements.reduce((a, b) => a + b)) * 10).toInt();
    }
    return flex;
  }
}

/// 15/11/2021 : fix text of the textfield reset to initValue when widget rebuild
class _GenerateTextField extends StatelessWidget {
  final GroupElement gElement;
  final List<GroupElement> groupElements;
  final TextElement element;
  final List<TextElement?>? textElements;
  final List<List<TextEditingController>> controllers;
  final List<List<FocusNode>>? focusList;
  final ValueNotifier<String?>? errorNotifier;

  _GenerateTextField({
    this.errorNotifier,
    required this.element,
    required this.gElement,
    required this.groupElements,
    this.textElements,
    required this.controllers,
    this.focusList,
  });

  @override
  Widget build(BuildContext context) {
    int gIndex = groupElements.indexOf(gElement);
    int eIndex = gElement.textElements.indexOf(element);
    var controller = controllers[gIndex][eIndex];

    var focusNodeNext = focusList![gIndex].length > (eIndex + 1)
        ? focusList![gIndex][eIndex + 1]
        : focusList!.length > gIndex + 1
            ? focusList![gIndex + 1].first
            : null;

    var focusNodeCurrent = focusList![gIndex].length > (eIndex)
        ? focusList![gIndex][eIndex]
        : focusList!.length > gIndex
            ? focusList![gIndex].first
            : null;

    if (element is PasswordElement) {
      return PasswordTextField(
        textEditingController: controller,
        element: element as PasswordElement?,
        errorNotifier: errorNotifier,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement),
        textInputType: Constants.getInput(element.typeInput),
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is CardExpirationDateInputElement) {
      return CardExpirationDateField(
        controller: controller,
        element: element as CardExpirationDateInputElement,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        errorNotifier: errorNotifier,
      );
    } else if (element is CardNumberElement) {
      return CardNumberField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element as CardNumberElement,
        errorNotifier: errorNotifier,
      );
    } else if (element is CVVElement) {
      return CvvTextField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element as CVVElement,
        errorNotifier: errorNotifier,
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
        element: element as CountryElement?,
      );
    } else if (element is EmailElement) {
      return EmailTextField(
        errorNotifier: errorNotifier,
        textEditingController: controller,
        emailElement: element as EmailElement?,
        inputDecoration:
            Constants.setInputBorder(context, element.decorationElement),
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is PhoneNumberElement) {
      return PhoneTextField(
        controller: controller,
        element: element as PhoneNumberElement,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is TextAreaElement) {
      return TextAreaFormField(
        element: element as TextAreaElement?,
        controller: controller,
      );
    } else if (element is DateElement) {
      return DateTextField(
        controller: controller,
        element: element as DateElement,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
      );
    } else if (element is DateInputElement) {
      return DateInputField(
        controller: controller,
        currentFocus: focusNodeCurrent,
        nextFocus: focusNodeNext,
        element: element as DateInputElement,
        errorNotifier: errorNotifier,
      );
    }
    if (errorNotifier != null) {
      return ValueListenableBuilder<String?>(
        valueListenable: errorNotifier!,
        builder: (ctx, error, _) {
          return TextFormField(
            controller: controller,
            validator: element.isRequired!
                ? (v) {
                    if (v!.isEmpty) {
                      return element.error;
                    }
                    if (element.validator != null) return element.validator!(v);
                    return null;
                  }
                : element.validator,
            keyboardType: Constants.getInput(element.typeInput),
            readOnly: element.readOnly,
            enabled: true,
            onTap: element.onTap as void Function()?,
            focusNode: focusNodeCurrent,
            textInputAction: focusNodeNext == null
                ? TextInputAction.done
                : TextInputAction.next,
            onFieldSubmitted: (v) {
              Constants.fieldFocusChange(
                  context, focusNodeCurrent, focusNodeNext);
            },
            decoration:
                Constants.setInputBorder(context, element.decorationElement)
                    .copyWith(
              labelText: element.label,
              hintText: element.hint,
              errorText: error,
              enabled: true,
              suffixIcon: null,
            ),
          );
        },
      );
    }
    return TextFormField(
      controller: controller,
      validator: element.isRequired!
          ? (v) {
              if (v != null && v.isEmpty) {
                return element.error;
              }
              if (element.validator != null) return element.validator!(v);
              return null;
            }
          : element.validator,
      keyboardType: Constants.getInput(element.typeInput),
      readOnly: element.readOnly,
      enabled: true,
      onTap: element.onTap as void Function()?,
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
