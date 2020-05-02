import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/email_text_field.dart';
import 'package:dynamic_form/src/password_text_field.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef loginCallback = Function(String username, String password);

class LoginForm extends StatefulWidget {
  final DecorationElement decorationElement;
  final DirectionGroup directionGroup;
  final EdgeInsets paddingFields;
  final bool onlyEmail;
  final String labelLogin;
  final String password;
  final Text textButton;
  final loginCallback callback;
  final double radiusBorderButton;
  final Color backgroundColorButton;
  final PasswordError passwordError;
  final double widthSubmitButton;
  final UsernameEmailError usernameEmailError;

  LoginForm({
    Key key,
    this.decorationElement,
    this.directionGroup = DirectionGroup.Vertical,
    this.paddingFields=const EdgeInsets.all(3.0),
    this.onlyEmail = true,
    this.labelLogin = "username or email",
    this.password = "Password",
    this.callback,
    this.textButton = const Text("LOG IN"),
    this.radiusBorderButton = 10.0,
    this.widthSubmitButton,
    this.passwordError = const PasswordError(),
    this.usernameEmailError = const UsernameEmailError(),
    this.backgroundColorButton,
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
    username=TextEditingController();
    password=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.directionGroup == DirectionGroup.Vertical) {
      return Column(
        mainAxisSize: MainAxisSize.max,
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
    return Container(
      width: widget.widthSubmitButton??MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
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
        color: widget.backgroundColorButton ?? Theme.of(context).primaryColor,
        textColor: widget.textButton?.style != null
            ? widget.textButton.style.color
            : Theme.of(context).textTheme.button.color,
        disabledColor: Colors.grey,
        splashColor: Theme.of(context).splashColor,
      ),
    );
  }

  List<Widget> fieldsForm() {
    return [
     Padding(
       padding: widget.paddingFields,
       child:  widget.onlyEmail
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
         style: widget.decorationElement.style,
         decoration:
         Constants.setInputBorder(context, widget.decorationElement)
             .copyWith(
             labelText: widget.labelLogin,
             hintText: widget.labelLogin),
       ),
     ),
      Padding(
        padding: widget.paddingFields,
        child: PasswordTextField(
          element: PasswordElement(
              label: widget.password,
              errors: widget.passwordError,
              hint: widget.password,
              decorationElement: widget.decorationElement,
              hasUppercase: true,
              isRequired: true,
              hasDigits: true,
              hasSpecialCharacter: true,
              minLength: 6),
          textEditingController: password,
          inputDecoration:
          Constants.setInputBorder(context, widget.decorationElement),
          textInputType: Constants.getInput(TypeInput.Password),
        ),
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
        }else{
          bool usernameValid =
          RegExp(Constants.emailPattern).hasMatch(usernameText);
          if (!usernameValid) {
            return widget.usernameEmailError.patternEmailErrorMsg;
          }
        }
      }else{
        bool emailValid = RegExp(Constants.emailPattern).hasMatch(usernameText);
        if (!emailValid) {
          return widget.usernameEmailError.patternEmailErrorMsg;
        }
      }


      return null;
    }
  }
}
