import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("test password controls login form", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginForm(
            callback: (email, password) {
              print("$email,$password");
            },
            buttonLoginDecorationElement: ButtonLoginDecorationElement(
                backgroundColorButton: Colors.white,
                widthSubmitButton: 200,
                shapeButtonLogin: StadiumBorder().copyWith(
                  side: BorderSide(
                    color: Colors.amber,
                    width: 0.6,
                  ),
                ),
                elevation: 0.0),
            onlyEmail: false,
            labelLogin: "Username",
            password: "Password",
            textButton: Text("Log IN"),
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

     v= password.validator("dali");
    expect(v, null);


  });
}
