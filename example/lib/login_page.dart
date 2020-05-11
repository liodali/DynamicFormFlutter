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
        print("$email,$password");
      },
      buttonLoginDecorationElement: ButtonLoginDecorationElement(
        backgroundColorButton: Colors.amber,
        widthSubmitButton: 200,
        radiusBorderButton: 10,
      ),
      onlyEmail: false,
      labelLogin: "Username",
      password: "Password",
      textButton: Text("Log IN"),
      decorationElement: RoundedDecorationElement(
        filledColor: Colors.grey[300],
      ),
    );
  }
}