import 'package:flutter/material.dart';

import '../../dynamic_form.dart';

/// [LoginForm]:Pre-existing form ,make easy to build your login form

/// [controller]
/// [decorationEmailElement] : input decoration of email/username fields of form
/// [decorationPasswordElement] : input decoration of password fields of form
/// [directionGroup] : Direction of form (Vertical/Horizontal)
///  [paddingFields] : padding between fields
///  [onlyEmail] : enable only email type fieldText
///  [login] : label  of username/email textField
///  [password] : label of the password field
///  [passwordError] : messages errors to show  when password field not validate
///  [usernameEmailError] : messages errors to show when email/username not validate

class LoginForm extends StatefulWidget {
  final LoginFormController controller;
  final DecorationLoginForm decorationLoginForm;
  final DirectionGroup directionGroup;
  final EdgeInsets paddingFields;
  final bool onlyEmail;
  final PasswordControls passwordControls;
  final PasswordError passwordError;
  final UsernameEmailError usernameEmailError;
  final Widget? submitLogin;

  LoginForm({
    Key? key,
    required this.controller,
    required this.decorationLoginForm,
    this.directionGroup = DirectionGroup.Vertical,
    this.paddingFields = const EdgeInsets.all(3.0),
    this.onlyEmail = true,
    this.submitLogin,
    this.passwordControls = const PasswordControls.strong(),
    this.passwordError = const PasswordError(),
    this.usernameEmailError = const UsernameEmailError(),
  }) : super(key: key);

  static LoginFormController of(BuildContext context, {bool nullOk = false}) {
    final LoginForm? result = context.findAncestorWidgetOfExactType<LoginForm>();
    if (nullOk || result != null) return result!.controller;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('LoginForm.of() called with a context that does not contain an LoginForm.'),
      ErrorDescription(
          'No LoginForm ancestor could be found starting from the context that was passed to LoginForm.of().'),
      context.describeElement('The context used was')
    ]);
  }

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  TextEditingController? username, password;
  late FormController controller;

  @override
  void initState() {
    super.initState();
    controller = FormController();
    username = TextEditingController();
    password = TextEditingController();
    widget.controller.init(this);
  }

  @override
  Widget build(BuildContext context) {
    Widget form = SimpleDynamicForm(
      controller: controller,
      padding: widget.paddingFields,
      groupElements: [
        GroupElement(
          directionGroup: widget.directionGroup,
          sizeElements: [
            0.5,
            0.5,
          ],
          backgroundColor: Colors.transparent,
          textElements: [
            widget.onlyEmail
                ? EmailElement(
                    id: "email",
                    decorationElement: widget.decorationLoginForm.decorationEmailElement,
                    isRequired: true,
                    padding: widget.paddingFields,
                    label: widget.decorationLoginForm.login,
                    hint: widget.decorationLoginForm.hintLogin ?? widget.decorationLoginForm.login,
                    errorEmailIsRequired: widget.usernameEmailError.requiredErrorMsg,
                    errorEmailPattern: widget.usernameEmailError.patternEmailErrorMsg,
                  )
                : TextElement(
                    id: "email",
                    validator: validatorUsername,
                    padding: widget.paddingFields,
                    textStyle: widget.decorationLoginForm.decorationEmailElement.style ??
                        Theme.of(context).textTheme.subtitle1,
                    decorationElement: widget.decorationLoginForm.decorationEmailElement,
                    label: widget.decorationLoginForm.login,
                    hint: widget.decorationLoginForm.login,
                  ),
            PasswordElement(
              id: "password",
              label: widget.decorationLoginForm.password,
              errors: widget.passwordError,
              hint: widget.decorationLoginForm.hintPassword ?? widget.decorationLoginForm.password,
              decorationElement: widget.decorationLoginForm.decorationPasswordElement,
              hasUppercase: widget.passwordControls.hasUppercase,
              isRequired: true,
              hasDigits: widget.passwordControls.hasDigits,
              hasSpecialCharacter: widget.passwordControls.hasSpecialCharacter,
              padding: widget.paddingFields,
              minLength: widget.passwordControls.passwordMinLength,
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
          if (widget.submitLogin != null) widget.submitLogin!,
        ],
      );
    }
    return Wrap(
      alignment: WrapAlignment.end,
      direction: Axis.horizontal,
      children: <Widget>[
        form,
        if (widget.submitLogin != null) widget.submitLogin!,
      ],
    );
  }

  String? validatorUsername(usernameText) {
    if (usernameText.isEmpty) {
      return widget.usernameEmailError.requiredErrorMsg;
    } else {
      if (!widget.onlyEmail) {
        if (!usernameText.contains("@")) {
          bool usernameValid = RegExp(Patterns.usernamePattern).hasMatch(usernameText);
          if (!usernameValid) {
            return widget.usernameEmailError.patternUsernameErrorMsg;
          }
        } else {
          bool usernameValid = RegExp(Patterns.emailPattern).hasMatch(usernameText);
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
