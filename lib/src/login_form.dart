import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/email_text_field.dart';
import 'package:dynamic_form/src/password_text_field.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
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
  final PasswordError passwordError;
  final UsernameEmailError usernameEmailError;

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
    this.passwordError,
    this.usernameEmailError,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> globalKeyForm;
  TextEditingController username, password;

  @override
  void initState() {
    super.initState();
    globalKeyForm = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.directionGroup == DirectionGroup.Vertical) {
      return Column(
        children: <Widget>[
          formWidget(),
          submitButton(),
        ],
      );
    }
    return Row(
      children: <Widget>[
        formWidget(),
        submitButton(),
      ],
    );
  }

  Widget formWidget() {
    return Form(
      key: globalKeyForm,
      child: widget.directionGroup == DirectionGroup.Vertical
          ? Column(
              children: fieldsForm(),
            )
          : Row(
              children: fieldsForm(),
            ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () async {
        if (globalKeyForm.currentState.validate()) {
          await widget.callback(username.text, password.text);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.radiusBorderButton),
        ),
      ),
      child: widget.textButton,
      color: Theme.of(context).primaryColor,
      textColor:
          widget.textButton.style.color ?? Theme.of(context).textTheme.button,
      disabledColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
    );
  }

  List<Widget> fieldsForm() {
    return [
      widget.onlyEmail
          ? EmailTextField(
              textEditingController: username,
              emailElement: EmailElement(
                decorationElement: widget.decorationElement,
                isRequired: true,
                label: widget.labelLogin,
                hint: widget.labelLogin,
                errorEmailIsRequired:
                    widget.usernameEmailError.requiredErrorMsg,
                errorEmailPattern:
                    widget.usernameEmailError.patternEmailErrorMsg,
              ),
            )
          : TextFormField(
              controller: username,
              validator: validatorUsername,
            ),
      PasswordTextField(

      ),
    ];
  }

  String validatorUsername(usernameText) {
    if (usernameText.isEmpty) {
      return widget.usernameEmailError.requiredErrorMsg;
    } else {
      if (!widget.onlyEmail) {
        if (!usernameText.contains("@")) {
          bool usernameValid =
              RegExp(Constants.usernamePattern).hasMatch(usernameText);
          if (!usernameValid) {
            return widget.usernameEmailError.patternUsernameErrorMsg;
          }
        }
      }
      bool emailValid = RegExp(Constants.emailPattern).hasMatch(usernameText);
      if (!emailValid) {
        return widget.usernameEmailError.patternEmailErrorMsg;
      }

      return null;
    }
  }
}
