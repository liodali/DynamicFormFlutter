import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'utilities/constants.dart';

class CardNumberField extends StatelessWidget {
  final CardNumberElement element;
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  CardNumberField({
    this.element,
    this.controller,
    this.currentFocus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    /*
      Visa cards – Begin with a 4 and have 13 or 16 digits
      Mastercard cards – Begin with a 5 and has 16 digits
      American Express cards – Begin with a 3, followed by a 4 or a 7  has 15 digits
      Discover cards – Begin with a 6 and have 16 digits
   */
    final ValueNotifier<Widget> iconNotifier = ValueNotifier(null);
    return TextFormField(
      controller: controller,
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
        suffixIcon: ValueListenableBuilder<Widget>(
          valueListenable: iconNotifier,
          builder: (ctx, child, _) {
            return Container(
                  width: 32.0,
                  alignment: Alignment.center,
                  child: child,
                ) ??
                SizedBox.shrink();
          },
        ),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return element.errorIsRequiredMessage;
        }
        if (v.length < 13) {
          return element.errorMsg ?? "credit card number is invalid";
        }
        if ((v.startsWith("4") && (v.length != 13 || v.length != 16)) &&
            (v.startsWith("5") && v.length != 16) &&
            ((v.startsWith("34") || v.startsWith("37")) && v.length != 15) &&
            (v.startsWith("6") && v.length != 16)) {
          return element.errorMsg ?? "credit card number is invalid";
        }

        return null;
      },
      onChanged: (v) {
        if (controller.text.length < 2 && controller.text.isNotEmpty) {
          String cardIconName = "";
          if (controller.text.startsWith("4")) {
            cardIconName = "assets/svg/visa.svg";
          } else if (controller.text.startsWith("5")) {
            cardIconName = "assets/svg/master-card.svg";
          } else if (controller.text.startsWith("3")) {
            cardIconName = "assets/svg/american-express.svg";
          } else if (controller.text.startsWith("6")) {
            cardIconName = "assets/svg/discover.svg";
          }
          if (cardIconName.isNotEmpty)
            iconNotifier.value = SvgPicture.asset(
              "packages/dynamic_form/$cardIconName",
              height: 24,
              width: 24,
            );
          else
            iconNotifier.value = null;
        }
      },
    );
  }
}
