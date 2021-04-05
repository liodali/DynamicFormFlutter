import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class PaymentExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = PaymentController();
    return PaymentForm(
      controller: controller,
      decorationElement: OutlineDecorationElement(),
      errorMessageCVV: "cvv is invalid",
      errorMessageDateExpiration: "date expiration is invalid",
      errorIsRequiredMessage: "This field  is required",
      labelCVV: "cvv",
      labelDateExpiration: "date expiration",
      labelCardNumber: "card number",
      submitButton: ElevatedButton(
        onPressed: () {
          controller.validate();
          print(controller.cardNumber);
          print(controller.cvv);
          print(controller.dateExpiration);
        },
        child: Text("pay"),
      ),
    );
  }
}
