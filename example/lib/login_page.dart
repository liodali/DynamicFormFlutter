import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final decoration = OutlineDecorationElement(
      filledColor: Colors.white,
      radius: BorderRadius.only(
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
      ),
      widthSide: 0.6,
    );
    final buttonDecoration = ButtonDecorationElement(
      backgroundColorButton: Colors.white,
      widthSubmitButton: 200,
      shapeButton: StadiumBorder().copyWith(
        side: BorderSide(
          color: Colors.amber,
          width: 0.6,
        ),
      ),
      elevation: 0.0,
    );
    return LoginForm(
      controller: FormController(),
      callback: (email, password) {
        print("$email,$password");
      },
      buttonLoginDecorationElement: buttonDecoration,
      onlyEmail: false,
      labelLogin: "Username",
      password: "Password",
      textButton: Text("Log IN"),
      paddingFields: const EdgeInsets.all(0),
      passwordControls: PasswordControls.all(
        false,
        passwordMinLength: 3,
      ),
      decorationEmailElement: decoration,
      decorationPasswordElement: decoration.copy(
        radius: BorderRadius.only(
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
    );
  }
}
