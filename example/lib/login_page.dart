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
      callback: (email,password){

      },
      backgroundColorButton: Colors.amber,
      onlyEmail: false,
      widthSubmitButton: 200,
      labelLogin: "Username",
      password: "Password",
      textButton: Text("Log IN"),
      radiusBorderButton: 10,
      decorationElement: RoundedDecorationElement(
        filledColor: Colors.grey[300],
      ),
    );
  }
}