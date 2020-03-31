import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey[300],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<SimpleDynamicFormState> _globalKey =
        GlobalKey<SimpleDynamicFormState>();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SimpleDynamicForm(
            key: _globalKey,
            groupElements: [
              GroupElement(
                margin: EdgeInsets.only(bottom: 5.0),
                directionGroup: DirectionGroup.Horizontal,
                sizeElements: [0.3],
                textElements: [
                  TextElement(
                      initValue: "",
                      label: "first name",
                      hint: "first name",
                      validator: (v) {
                        if (v.isEmpty) {
                          return "err";
                        }
                        return null;
                      }),
                  TextElement(label: "last name"),
                ],
              ),
              GroupElement(
                directionGroup: DirectionGroup.Vertical,
                textElements: [
                  NumberElement(
                      label: "phone",
                      validator: (v) {
                        if (v.isEmpty) {
                          return "err";
                        }
                        return null;
                      }),
                  EmailElement(label: "name"),
                  PasswordElement(),
                ],
              ),
              GroupElement(
                directionGroup: DirectionGroup.Vertical,
                textElements: [
                  CountryElement(
                    label: "Pays",
                    labelModalSheet: "Pays",
                    labelSearchModalSheet: "search",
                    initValue: "TUN",
                    countryTextResult: CountryTextResult.countryCode,
                    showFlag: false,
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              print(_globalKey.currentState.validate());
              print(_globalKey.currentState.recuperateAllValues());
            },
            child: Text("Validate"),
          )
        ],
      ),
    );
  }
}
