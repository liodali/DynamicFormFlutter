import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

typedef loginCallback = Function(String username, String password);

/// [LoginForm]:Pre-existing form ,make easy to build your login form

/// [decorationEmailElement] : input decoration of email/username fields of form
/// [decorationPasswordElement] : input decoration of password fields of form
/// [directionGroup] : Direction of form (Vertical/Horizontal)
///  [paddingFields] : padding between fields
///  [onlyEmail] : enable only email type fieldtext
///  [labelLogin] : label  of username/email textField
///  [password] : label of the password field
///  [textButton] : Text widget of the submit button
///  [callback] : callback to make your api call when you form is validate
///  [buttonLoginDecorationElement] : decoration of  button  that contain radius,width,color
///  [passwordError] : messages errors to show  when password field not validate
///  [usernameEmailError] : messages errors to show when email/username not validate

class LoginForm extends StatefulWidget {
  final DecorationElement decorationEmailElement;
  final DecorationElement decorationPasswordElement;
  final DirectionGroup directionGroup;
  final EdgeInsets paddingFields;
  final bool onlyEmail;
  final String labelLogin;
  final String password;
  final Text textButton;
  final loginCallback callback;
  final PasswordError passwordError;
  final UsernameEmailError usernameEmailError;
  final ButtonLoginDecorationElement buttonLoginDecorationElement;

  LoginForm({
    Key key,
    this.decorationEmailElement = const UnderlineDecorationElement(),
    this.decorationPasswordElement = const UnderlineDecorationElement(),
    this.directionGroup = DirectionGroup.Vertical,
    this.paddingFields = const EdgeInsets.all(3.0),
    this.onlyEmail = true,
    this.labelLogin = "username or email",
    this.password = "Password",
    this.callback,
    this.textButton = const Text("LOG IN"),
    this.passwordError = const PasswordError(),
    this.usernameEmailError = const UsernameEmailError(),
    this.buttonLoginDecorationElement = const ButtonLoginDecorationElement(),
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<SimpleDynamicFormState> globalKeyDynamic;
  TextEditingController username, password;

  @override
  void initState() {
    super.initState();

    globalKeyDynamic = GlobalKey<SimpleDynamicFormState>();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = SimpleDynamicForm(
      key: globalKeyDynamic,
      padding: widget.paddingFields,
      groupElements: [
        GroupElement(
          directionGroup: widget.directionGroup,
          backgroundColor: Colors.transparent,
          textElements: [
            widget.onlyEmail
                ? EmailElement(
                    decorationElement: widget.decorationEmailElement,
                    isRequired: true,
                    padding: widget.paddingFields,
                    label: widget.labelLogin,
                    hint: widget.labelLogin,
                    errorEmailIsRequired:
                        widget.usernameEmailError.requiredErrorMsg,
                    errorEmailPattern:
                        widget.usernameEmailError.patternEmailErrorMsg,
                  )
                : TextElement(
                    validator: validatorUsername,
                    padding: widget.paddingFields,
                    textStyle: widget.decorationEmailElement.style ??
                        Theme.of(context).textTheme.subtitle1,
                    decorationElement: widget.decorationEmailElement,
                    label: widget.labelLogin,
                    hint: widget.labelLogin,
                  ),
            PasswordElement(
              label: widget.password,
              errors: widget.passwordError,
              hint: widget.password,
              decorationElement: widget.decorationPasswordElement,
              hasUppercase: true,
              isRequired: true,
              hasDigits: true,
              hasSpecialCharacter: true,
              padding: widget.paddingFields,
              minLength: 6,
            ),
          ],
        ),
      ],
    );
    if (widget.directionGroup == DirectionGroup.Vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          form,
          submitButton(),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        form,
        submitButton(),
      ],
    );
  }

  Widget submitButton() {
    return Container(
      width: widget.buttonLoginDecorationElement.widthSubmitButton,
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
        onPressed: () async {
          if (globalKeyDynamic.currentState.validate()) {
            await widget.callback(
                globalKeyDynamic.currentState.recuperateAllValues()[0],
                globalKeyDynamic.currentState.recuperateAllValues()[1]);
          }
        },
        elevation: widget.buttonLoginDecorationElement.elevation,
        shape: widget.buttonLoginDecorationElement.shapeButtonLogin,
        color: widget.buttonLoginDecorationElement.backgroundColorButton ??
            Theme.of(context).primaryColor,
        textColor: widget.textButton?.style != null
            ? widget.textButton.style.color
            : Theme.of(context).textTheme.button.color,
        child: widget.textButton,
      ),
    );
  }

  String validatorUsername(usernameText) {
    if (usernameText.isEmpty) {
      return widget.usernameEmailError.requiredErrorMsg;
    } else {
      if (!widget.onlyEmail) {
        if (!usernameText.contains("@")) {
          bool usernameValid =
              RegExp(Patterns.usernamePattern).hasMatch(usernameText);
          if (!usernameValid) {
            return widget.usernameEmailError.patternUsernameErrorMsg;
          }
        } else {
          bool usernameValid =
              RegExp(Patterns.emailPattern).hasMatch(usernameText);
          if (!usernameValid) {
            return widget.usernameEmailError.patternEmailErrorMsg;
          }
        }
      } else {
        bool emailValid = RegExp(Patterns.emailPattern).hasMatch(usernameText);
        if (!emailValid) {
          return widget.usernameEmailError.patternEmailErrorMsg;
        }
      }

      return null;
    }
  }
}
