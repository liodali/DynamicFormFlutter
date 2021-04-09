import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets("payment form test", (tester) async {
    final controller = PaymentController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PaymentForm(
            controller: controller,
            maxYearDateExpiration: 2025,
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
    final inputDateMonth =
        tester.widget(find.byType(TextFormField).at(1)) as TextFormField;
    final inputDateYear =
    tester.widget(find.byType(TextFormField).at(2)) as TextFormField;
    final inputCVV =
        tester.widget(find.byType(TextFormField).at(3)) as TextFormField;

    inputCardNb.controller!.text = "4555555555555555";
    inputCVV.controller!.text = "455";
    inputDateMonth.controller!.text = "11";
    inputDateYear.controller!.text = "2024";

    await tester.pump();
    expect(controller.validate(), true);
    expect(controller.cardNumber, "4555555555555555");
    expect(controller.cvv, "455");
    expect(find.text("11"),findsOneWidget);
    expect(find.text("2024"),findsOneWidget);
    inputDateYear.controller!.text = "2032";
    expect(controller.validate(), false);


  });

  test("test conversion",()async{
    String m = DateFormat('MMM').format(DateTime(0, 2));
    print(m);
  });

}
