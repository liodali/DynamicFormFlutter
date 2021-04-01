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
    final controller = LoginFormController();
    return LoginForm(
      controller: controller,
      directionGroup: DirectionGroup.Horizontal,
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
      login: "Username",
      password: "Password",
      paddingFields: const EdgeInsets.all(2),
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
