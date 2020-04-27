import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/email_text_field.dart';
import 'package:flutter/material.dart';

typedef loginCallback = Function(String username, String password);

class LoginForm extends StatefulWidget {
  final DecorationElement decorationElement;
  final DirectionGroup directionGroup;
  final bool onlyEmail;
  final String labelLogin;
  final String password;
  final Text textButton;
  final loginCallback callback;
  final double radiusBorderButton;

  LoginForm({
    Key key,
    this.decorationElement,
    this.directionGroup = DirectionGroup.Vertical,
    this.onlyEmail = true,
    this.labelLogin = "username or email",
    this.password = "Password",
    this.callback,
    this.textButton = const Text("LOG IN"),
    this.radiusBorderButton = 10.0,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          child: widget.directionGroup == DirectionGroup.Vertical
              ? Column(
                  children: fieldsForm(),
                )
              : Row(
                  children: fieldsForm(),
                ),
        ),
        RaisedButton(
          onPressed: null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radiusBorderButton),
            ),
          ),
          child: widget.textButton,
        )
      ],
    );
  }

  List<Widget> fieldsForm() {
    return [
      widget.onlyEmail?
      EmailTextField(
        emailElement: EmailElement(
          decorationElement: widget.decorationElement,
          isRequired: true,
          label: widget.labelLogin,
          hint: widget.labelLogin,

        ),
      ):TextFormField(),
    ];
  }
}
