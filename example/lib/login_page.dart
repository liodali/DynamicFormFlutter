import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginFormController();

  @override
  Widget build(BuildContext context) {
    final decoration = OutlineDecorationElement(
      filledColor: Colors.white,
      radius: BorderRadius.only(
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
      ),
      widthSide: 0.6,
      focusWidthSide: 1.0,
    );
    return LoginForm(
      controller: controller,
      directionGroup: DirectionGroup.Vertical,
      submitLogin: Container(
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            final email = controller.email;
            final password = controller.password;
            controller.validate();
            if (email != "dali") {
              controller.addEmailError("invalid Email not found");
            }
            print("$email,$password");
          },
          child: Text("Log In"),
        ),
      ),
      onlyEmail: false,
      decorationLoginForm: DecorationLoginForm(
        commonDecoration: decoration,
        decorationEmailElement: OutlineDecorationElement(
          contentPadding: EdgeInsets.only(
            left: 12.0,
          ),
          // prefix: Icon(
          //   Icons.person,
          //   size: 20,
          // ),
        ),
        decorationPasswordElement: OutlinePasswordElementDecoration(
          contentPadding: EdgeInsets.only(left: 8),
          prefix: Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(
              Icons.lock,
              size: 20,
            ),
          ),
          enableVisibilityPassword: false
          // showPasswordWidget: Icon(
          //   Icons.remove_red_eye_outlined,
          // ),
          // hidePasswordWidget: Icon(
          //   Icons.visibility_off_outlined,
          // ),
        ),
        // login: "Username",
        // password: "password",
        hintPassword: "password",
      ),
      paddingFields: const EdgeInsets.all(6),
      passwordControls: PasswordControls.all(
        false,
        passwordMinLength: 3,
      ),
    );
  }
}
