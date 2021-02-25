import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("test password controls login form", (tester) async {
    final controller = LoginFormController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginForm(
            controller: controller,
            onlyEmail: false,
            login: "Username",
            password: "Password",
            paddingFields: const EdgeInsets.all(0),
            passwordError: PasswordError(
              minLengthErrorMsg: "min length is 3"
            ),
            passwordControls: PasswordControls.all(
              false,
              passwordMinLength: 3,
            ),
            decorationEmailElement: OutlineDecorationElement(
              filledColor: Colors.white,
              radius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              widthSide: 0.6,
            ),
            decorationPasswordElement: OutlineDecorationElement(
              filledColor: Colors.white,
              radius: BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
              widthSide: 0.6,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    TextFormField password =
        tester.widget(find.byType(TextFormField).at(1)) as TextFormField;



    String v= password.validator("da");
    expect(v, "min length is 3");
    password.controller.text ="dali";
    expect(controller.password, "dali");
    controller.addPasswordError("password Error");
    await tester.pump();
    var widgetText = tester.widget(find.byType(TextField).last) as TextField;
    expect(widgetText.decoration.errorText, "password Error");
    controller.validate();
    await tester.pump(Duration(seconds: 1));
    widgetText = tester.widget(find.byType(TextField).last) as TextField;
    expect(widgetText.decoration.errorText, null);


  });
}
