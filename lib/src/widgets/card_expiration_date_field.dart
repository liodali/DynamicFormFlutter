import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

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
                  controller: TextEditingController(),
                  maxLength: 2,
                  buildCounter: buildCounter,
                  keyboardType: Constants.getInput(element.typeInput),
                  readOnly: element.readOnly,
                  enabled: true,
                  //onTap: element.onTap as void Function()?,
                  focusNode: monthFocus,
                  textInputAction: nextFocus == null
                      ? TextInputAction.done
                      : TextInputAction.next,
                  onFieldSubmitted: (v) {
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
                          context, element.decorationElement)
                      .copyWith(
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
                  controller: TextEditingController(),
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
                    if (int.parse(year!) < DateTime.now().year ||
                        int.parse(year) > maxYear) {
                      return element.invalidErrorMsg;
                    }
                  },
                  focusNode: yearFocus,
                  textInputAction: nextFocus == null
                      ? TextInputAction.done
                      : TextInputAction.next,
                  onFieldSubmitted: (v) {
                    Constants.fieldFocusChange(context, yearFocus, nextFocus);
                  },
                  decoration: Constants.setInputBorder(
                          context, element.decorationElement)
                      .copyWith(
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
    );
  }
}
