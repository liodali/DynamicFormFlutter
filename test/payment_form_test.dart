import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("payment form test", (tester) async {
    final controller = PaymentController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PaymentForm(
            controller: controller,
            decorationElement: OutlineDecorationElement(),
            errorMessageCVV: "cvv is invalid",
            errorMessageDateExpiration: "date expiration is invalid",
            labelCVV: "cvv",
            labelDateExpiration: "date expiration",
            labelCardNumber: "card number",
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


    inputCardNb.controller!.text = "4555555555555555";
    inputCVV.controller!.text = "455";
    inputDate.controller!.text = "11/2022";

    await tester.pump();
    expect(controller.validate(), true);
    expect(controller.cardNumber,"4555555555555555");
    expect(controller.cvv,"455");
    expect(controller.dateExpiration,"11/2022");

  });
}
