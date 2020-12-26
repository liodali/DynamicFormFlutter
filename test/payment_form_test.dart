import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("small test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PaymentForm(
            decorationElement: OutlineDecorationElement(),
            actionPayment: (cardNumber, cvv, date) async {},
            errorMessageCVV: "cvv is invalid",
            errorMessageDateExpiration: "date expiration is invalid",
            labelCVV: "cvv",
            labelDateExpiration: "date expiration",
            labelCardNumber: "card number",
            paymentText: Text("purchase"),
          ),
        ),
      ),
    );
    await tester.pump();

    final inputCardNb =
        tester.widget(find.byType(TextFormField).at(0)) as TextFormField;
    final inputDate =
        tester.widget(find.byType(TextFormField).at(1)) as TextFormField;
    final inputCVV = tester.widget(find.byType(TextFormField).at(2)) as TextFormField;


    inputCardNb.controller.text = "4555555555555555";
    inputCVV.controller.text = "455";
    inputDate.controller.text = "11/20";

    await tester.pump();

    await tester.tap(find.byType(RaisedButton));

    expect(inputCardNb.controller.value.text,"4555555555555555");
    expect(inputDate.validator("11/20"),"date expiration is invalid");
    expect(inputCVV.validator("45"),"cvv is invalid");
  });
}
