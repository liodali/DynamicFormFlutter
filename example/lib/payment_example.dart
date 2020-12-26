import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class PaymentExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaymentForm(
      decorationElement: OutlineDecorationElement(),
      actionPayment: (cardNumber, cvv, date) async {
        print("Credit Card information : $cardNumber,$cvv,$date");
      },
      errorMessageCVV: "cvv is invalid",
      errorMessageDateExpiration: "date expiration is invalid",
      errorIsRequiredMessage: "This field  is required",
      labelCVV: "cvv",
      labelDateExpiration: "date expiration",
      labelCardNumber: "card number",
      paymentText: Text("purchase"),
    );
  }
}
