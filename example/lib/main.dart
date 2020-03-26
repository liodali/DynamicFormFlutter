import 'package:dynamicform/dynamicform.dart';
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
  GlobalKey<SimpleDynamicFormState> _globalKey;

  @override
  Widget build(BuildContext context) {
    _globalKey = GlobalKey<SimpleDynamicFormState>();
    return Center(
      child: Column(
        children: <Widget>[
          SimpleDynamicForm(
            key: _globalKey,
            groupElements: [
              GroupElement(
                directionGroup: DirectionGroup.Horizontal,
                sizeElements: [0.3],
                textElements: [
                  TextElement(
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
                    TextElement(label: "name"),
                    TextElement(
                        label: "password", typeInput: TypeInput.Password)
                  ])
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
