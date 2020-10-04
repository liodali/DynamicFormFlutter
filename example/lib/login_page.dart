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
    return LoginForm(
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
    );
  }
}
