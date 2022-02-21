import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class CardExpirationDateField extends StatelessWidget {
  final CardExpirationDateInputElement element;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;
  final DecorationElement? commonDecorationElem;

  CardExpirationDateField({
    required this.element,
    required this.controller,
    this.currentFocus,
    this.nextFocus,
    this.errorNotifier,
    this.commonDecorationElem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthFocus = FocusNode();
    final yearFocus = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (element.label != null) ...[
          Text(
            element.label ?? "Date Expiration",
          ),
        ],
        if (element.entryMode == DateExpirationEntryMode.dropdown) ...[
          DropdownDateExpiration(
            element: element,
            maxYear: element.maxYear ?? (DateTime.now().year + 10),
            controller: controller,
            errorNotifier: errorNotifier,
          )
        ] else ...[
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: controller.text.isNotEmpty ? controller.text.split("/").first : ""),
                    maxLength: 2,
                    buildCounter: buildCounter,
                    keyboardType: Constants.getInput(element.typeInput),
                    readOnly: element.readOnly,
                    enabled: true,
                    //onTap: element.onTap as void Function()?,
                    focusNode: monthFocus,
                    textInputAction:
                        nextFocus == null ? TextInputAction.done : TextInputAction.next,
                    onFieldSubmitted: (v) {
                      monthFocus.unfocus();
                      Constants.fieldFocusChange(context, monthFocus, yearFocus);
                    },
                    validator: (month) {
                      if (element.isRequired && month!.isEmpty) {
                        return element.requiredErrorMsg;
                      }
                      if (int.parse(month!) < 1 || int.parse(month) > 12) {
                        return element.invalidErrorMsg;
                      }
                    },
                    onChanged: (v) {
                      final yearValue = controller.text.split("/")[1];
                      controller.text = "$v/$yearValue";
                    },
                    decoration: Constants.setInputBorder(
                      context,
                      element.decorationElement,
                      common: commonDecorationElem,
                    ).copyWith(
                      labelText: "MM",
                      hintText: "MM",
                      //errorText: error,
                      enabled: true,
                      suffixIcon: null,
                      contentPadding: EdgeInsets.all(2.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: TextEditingController(
                        text: controller.text.isNotEmpty ? controller.text.split("/").last : ""),
                    maxLength: 4,
                    buildCounter: buildCounter,
                    keyboardType: Constants.getInput(element.typeInput),
                    readOnly: element.readOnly,
                    enabled: true,
                    onTap: element.onTap as void Function()?,
                    onChanged: (v) {
                      final monthValue = controller.text.split("/").first;
                      controller.text = "$monthValue/$v";
                    },
                    validator: (year) {
                      final maxYear = element.maxYear ?? DateTime.now().year + 10;
                      if (element.isRequired && year!.isEmpty) {
                        return element.requiredErrorMsg;
                      }
                      if (int.parse(year!) < DateTime.now().year || int.parse(year) > maxYear) {
                        return element.invalidErrorMsg;
                      }
                    },
                    focusNode: yearFocus,
                    textInputAction:
                        nextFocus == null ? TextInputAction.done : TextInputAction.next,
                    onFieldSubmitted: (v) {
                      yearFocus.unfocus();
                      Constants.fieldFocusChange(context, yearFocus, nextFocus);
                    },
                    decoration: Constants.setInputBorder(
                      context,
                      element.decorationElement,
                      common: commonDecorationElem,
                    ).copyWith(
                      labelText: "YYYY",
                      hintText: "YYYY",
                      //errorText: error,
                      enabled: true,
                      suffixIcon: null,
                      contentPadding: EdgeInsets.all(2.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class DropdownDateExpiration extends StatelessWidget {
  final CardExpirationDateInputElement element;
  final TextEditingController controller;
  final int maxYear;
  final currentYear = DateTime.now().year;
  final ValueNotifier<String?>? errorNotifier;

  DropdownDateExpiration({
    required this.element,
    required this.controller,
    required this.maxYear,
    required this.errorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<int>> notifierMM = ValueNotifier([]);
    final ValueNotifier<List<int>> notifierYYYY = ValueNotifier([]);
    final yearRange = maxYear - currentYear;
    final currentMonth = DateTime.now().month;
    if (currentMonth > 1) {
      notifierMM.value = List.generate(currentMonth - 1, (index) => index);
    }
    controller.text = "$currentMonth/$currentYear";
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: false,
          child: TextFormField(
            controller: controller,
            validator: (v) {
              if (v!.isEmpty) {
                errorNotifier?.value = element.requiredErrorMsg;
                return element.requiredErrorMsg;
              }
            },
          ),
        ),
        _SpinnerWidget(
          onTapItem: (index) {
            final yearValue = controller.text.split("/").last;
            String month = DateFormat('MM').format(DateTime(0, index + 1));
            controller.text = "$month/$yearValue";
          },
          onChangedItem: (v) {
            final _currentMonth = v;
            if (_currentMonth < currentMonth) {
              notifierYYYY.value = [0];
            } else {
              notifierYYYY.value = [];
            }
          },
          hint: "MM",
          initValue: DateTime.now().month,
          notifierDisableValues: notifierMM,
          notifierError: errorNotifier,
          size: 12,
          builder: (ctx, index, isDisabled) {
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                "${index + 1}-${DateFormat('MMM').format(DateTime(0, index + 1))}",
                style: TextStyle(
                  color: isDisabled ? Colors.grey : null,
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: 12.0,
        ),
        _SpinnerWidget(
          onTapItem: (index) {
            final monthValue = controller.text.split("/").first;
            controller.text = "$monthValue/${currentYear + index}";
          },
          onChangedItem: (v) {
            if (v == 1 && DateTime.now().month > 1) {
              notifierMM.value = List.generate(yearRange, (index) => index)
                ..removeWhere((e) => e >= (DateTime.now().month - 1));
            } else {
              notifierMM.value = [];
            }
          },
          hint: "YYYY",
          initValue:
              List.generate(yearRange, (index) => currentYear + index).indexOf(currentYear) + 1,
          notifierDisableValues: notifierYYYY,
          notifierError: errorNotifier,
          size: yearRange,
          builder: (ctx, index, isDisabled) {
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                "${currentYear + index}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: isDisabled ? Colors.grey : null,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SpinnerWidget extends StatefulWidget {
  final Function(int) onTapItem;
  final Function(int)? onChangedItem;
  final int size;
  final int? initValue;
  final Function(BuildContext, int, bool) builder;
  final String hint;
  final ValueNotifier<String?>? notifierError;
  final ValueNotifier<List<int>> notifierDisableValues;

  _SpinnerWidget({
    required this.onTapItem,
    this.onChangedItem,
    this.initValue,
    required this.size,
    required this.builder,
    required this.hint,
    required this.notifierError,
    required this.notifierDisableValues,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<_SpinnerWidget> {
  late int value = 1;
  List<int> disabledValues = [];

  Color? errorColor;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      assert(widget.initValue! >= 1);
      value = widget.initValue!;
    }
    if (widget.notifierDisableValues.value.isNotEmpty) {
      disabledValues = widget.notifierDisableValues.value;
      if (disabledValues.contains(value)) {
        value = List.generate(widget.size, (index) => (index + 1))
            .firstWhere((element) => !disabledValues.contains(element));
      }
    }
    widget.notifierError?.addListener(listenerError);
    widget.notifierDisableValues.addListener(listenerValue);
  }

  @override
  void dispose() {
    widget.notifierError?.addListener(listenerError);
    widget.notifierDisableValues.addListener(listenerValue);
    super.dispose();
  }

  void listenerError() {
    if (widget.notifierError != null &&
        widget.notifierError!.value != null &&
        widget.notifierError!.value!.isNotEmpty) {
      setState(() {
        errorColor = Colors.red;
      });
    }
  }

  void listenerValue() {
    if (widget.notifierDisableValues.value.isNotEmpty) {
      setState(() {
        disabledValues = widget.notifierDisableValues.value;
        if (disabledValues.contains(value)) {
          value = List.generate(widget.size, (index) => (index + 1))
              .firstWhere((element) => !disabledValues.contains(element));
        }
      });
    } else {
      setState(() {
        disabledValues = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      itemHeight: 56,
      onChanged: (v) {
        setState(() {
          if (!disabledValues.contains(v!)) {
            if (widget.onChangedItem != null) widget.onChangedItem!(v);
            value = v;
          }
        });
      },
      hint: Text(widget.hint),
      underline: errorColor != null
          ? Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: errorColor!,
                    width: 2.0,
                  ),
                ),
              ),
            )
          : null,
      value: value,
      items: List.generate(
        widget.size,
        (index) => DropdownMenuItem(
          value: index + 1,
          child: widget.builder(context, index, disabledValues.contains(index)),
          onTap: disabledValues.contains(index) ? null : () => widget.onTapItem(index),
        ),
      ),
    );
  }
}
