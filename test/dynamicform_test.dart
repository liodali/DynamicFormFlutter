import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("test setFieldValue", (tester) async {
    final controller = FormController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SimpleDynamicForm(
          controller: controller,
          groupElements: [
            GroupElement(
              margin: EdgeInsets.only(bottom: 5.0),
              directionGroup: DirectionGroup.Horizontal,
              sizeElements: [0.3],
              textElements: [
                TextElement(
                    id: "id_first_name",
                    initValue: "",
                    label: "first name",
                    hint: "first name",
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "err";
                      }
                      return null;
                    }),
                TextElement(
                    label: "last name",
                    isRequired: true,
                    initValue: "your name",
                    validator: (v) {
                      if (v != "your name") {
                        return "name not accepted";
                      }
                      return null;
                    }),
              ],
            ),
          ],
        ),
      ),
    ));
    await tester.pumpAndSettle(Duration(seconds: 1));
     TextFormField firstNameTextField = tester.widget(find.byType(TextFormField).first);
    final TextFormField lastNameTextField = tester.widget(find.byType(TextFormField).last);
    expect(firstNameTextField.initialValue?.isEmpty, true);
    expect(lastNameTextField.initialValue, "your name");

    controller.setFieldValueById("id_first_name", "Mohamed");
    await tester.pumpAndSettle(Duration(seconds: 1));
     firstNameTextField = tester.widget(find.byType(TextFormField).first);
    expect(firstNameTextField.controller!.text, "Mohamed");

  });


  testWidgets("test password controls login form", (tester) async {
    final controller = LoginFormController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginForm(
            controller: controller,
            decorationLoginForm: DecorationLoginForm(
              decorationEmailElement: OutlineDecorationElement(
                filledColor: Colors.white,
                radius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
                widthSide: 0.6,
              ),
              decorationPasswordElement: OutlinePasswordElementDecoration(
                filledColor: Colors.white,
                radius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                widthSide: 0.6,
              ),
              login: "Username",
              password: "Password",
            ),
            onlyEmail: false,
            paddingFields: const EdgeInsets.all(0),
            passwordError: PasswordError(minLengthErrorMsg: "min length is 3"),
            passwordControls: PasswordControls.all(
              false,
              passwordMinLength: 3,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    TextFormField password = tester.widget(find.byType(TextFormField).at(1)) as TextFormField;

    String? v = password.validator!("da");
    expect(v, "min length is 3");
    password.controller!.text = "dali";
    expect(controller.password, "dali");
    controller.addPasswordError("password Error");
    await tester.pump();
    var widgetText = tester.widget(find.byType(TextField).last) as TextField;
    expect(widgetText.decoration!.errorText, "password Error");
    controller.validate();
    await tester.pump(Duration(seconds: 1));
    widgetText = tester.widget(find.byType(TextField).last) as TextField;
    expect(widgetText.decoration!.errorText, null);
  });
}
