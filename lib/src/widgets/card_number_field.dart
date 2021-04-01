import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/text_controller_format_input.dart';

/// Widget to illustrate card number text field
///
/// [element] : (CardNumberElement) blueprint element
///
/// [controller] : text controller of textField
///
/// [currentFocus] : current focus of the textField
///
/// [nextFocus] : next focus of the textField
///
/// [errorNotifier] : (ValueNotifier) to get error message when textField is not valid
class CardNumberField extends StatelessWidget {
  final CardNumberElement element;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final ValueNotifier<String?>? errorNotifier;

  CardNumberField({
    required this.element,
    required this.controller,
    this.currentFocus,
    this.nextFocus,
    this.errorNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
      Visa cards – Begin with a 4 and have 13 or 16 digits
      Mastercard cards – Begin with a 5 and has 16 digits
      American Express cards – Begin with a 3, followed by a 4 or a 7  has 15 digits
      Discover cards – Begin with a 6 and have 16 digits
   */
    final ValueNotifier<Widget?> iconNotifier = ValueNotifier(null);
    final TextControllerFormatInput inputController = TextControllerFormatInput(
        mask: "XXXX-XXXX-XXXX-XXXX",
        text: controller.text,
        translator: {
          "X": RegExp(r'[0-9]'),
        });
    inputController.addListener(() {
      controller.text = inputController.text.replaceAll("-", "");
    });
    if (errorNotifier != null) {
      return ValueListenableBuilder<String?>(
        valueListenable: errorNotifier!,
        builder: (ctx, error, _) {
          return TextFormField(
            controller: inputController,
            keyboardType: TextInputType.datetime,
            focusNode: currentFocus,
            textInputAction:
                nextFocus == null ? TextInputAction.done : TextInputAction.next,
            decoration:
                Constants.setInputBorder(context, element.decorationElement)
                    .copyWith(
              labelStyle: element.textStyle ??
                  Theme.of(context).inputDecorationTheme.labelStyle,
              errorStyle: element.errorStyle ??
                  Theme.of(context).inputDecorationTheme.labelStyle,
              hintText: element.hint,
              labelText: element.label,
              errorText: error,
              suffixIcon: ValueListenableBuilder<Widget?>(
                valueListenable: iconNotifier,
                builder: (ctx, child, _) {
                  if (child == null) {
                    return SizedBox.shrink();
                  }
                  return Container(
                    width: 32.0,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
              ),
            ),
            validator: (value) {
              final number = controller.text;
              if (number.isEmpty) {
                return element.errorIsRequiredMessage;
              }
              if (number.length < 13) {
                return element.errorMsg ?? "credit card number is invalid";
              }
              if ((number.startsWith("4") &&
                      (number.length != 13 && number.length != 16)) ||
                  (number.startsWith("5") && number.length != 16) ||
                  ((number.startsWith("34") && number.startsWith("37")) &&
                      number.length != 15) ||
                  (number.startsWith("6") && number.length != 16)) {
                return element.errorMsg ?? "credit card number is invalid";
              }

              return null;
            },
            onChanged: (v) {
              if (controller.text.length < 2) {
                if (controller.text.isEmpty) {
                  iconNotifier.value = null;
                } else {
                  String cardIconName = getCardImagePathFromNB(controller.text);
                  if (cardIconName.isNotEmpty)
                    iconNotifier.value = Image.asset(
                      "packages/dynamic_form/$cardIconName",
                      height: 24,
                      width: 24,
                    );
                  else {
                    iconNotifier.value = null;
                  }
                }
              }
              //controller.text = inputController.text.replaceAll("-", "");
            },
          );
        },
      );
    }
    return TextFormField(
      controller: inputController,
      keyboardType: TextInputType.datetime,
      focusNode: currentFocus,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      decoration:
          Constants.setInputBorder(context, element.decorationElement).copyWith(
        labelStyle: element.textStyle ??
            Theme.of(context).inputDecorationTheme.labelStyle,
        errorStyle: element.errorStyle ??
            Theme.of(context).inputDecorationTheme.labelStyle,
        hintText: element.hint,
        labelText: element.label,
        suffixIcon: ValueListenableBuilder<Widget?>(
          valueListenable: iconNotifier,
          builder: (ctx, child, _) {
            if (child == null) {
              return SizedBox.shrink();
            }
            return Container(
              width: 32.0,
              alignment: Alignment.center,
              child: child,
            );
          },
        ),
      ),
      validator: (value) {
        final number = controller.text;
        if (number.isEmpty) {
          return element.errorIsRequiredMessage;
        }
        if (number.length < 13) {
          return element.errorMsg ?? "credit card number is invalid";
        }
        if ((number.startsWith("4") &&
                (number.length != 13 && number.length != 16)) ||
            (number.startsWith("5") && number.length != 16) ||
            ((number.startsWith("34") && number.startsWith("37")) &&
                number.length != 15) ||
            (number.startsWith("6") && number.length != 16)) {
          return element.errorMsg ?? "credit card number is invalid";
        }

        return null;
      },
      onChanged: (v) {
        if (controller.text.length < 2) {
          if (controller.text.isEmpty) {
            iconNotifier.value = null;
          } else {
            String cardIconName = getCardImagePathFromNB(controller.text);
            if (cardIconName.isNotEmpty)
              iconNotifier.value = Image.asset(
                "packages/dynamic_form/$cardIconName",
                height: 24,
                width: 24,
              );
            else {
              iconNotifier.value = null;
            }
          }
        }
      },
    );
  }
}

String getCardImagePathFromNB(String text) {
  String cardIconName = "";
  if (text.startsWith("4")) {
    cardIconName = "assets/png/visa.png";
  } else if (text.startsWith("5")) {
    cardIconName = "assets/png/mastercard.png";
  } else if (text.startsWith("3")) {
    cardIconName = "assets/png/american-express.png";
  } else if (text.startsWith("6")) {
    cardIconName = "assets/png/discover.png";
  }
  return cardIconName;
}
