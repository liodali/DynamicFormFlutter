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
class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SimpleDynamicForm(
        groupElements: [
          GroupElement(
            directionGroup: DirectionGroup.Horizontal,
            sizeElements: [0.3,0.1,0.2],
            textElements: [
              TextElement(
                label: "first name"
              ),
              TextElement(
                label: "last name"
              ),
              TextElement(
                  label: "pseudo name"
              )
            ]
          ),
          GroupElement(
              directionGroup: DirectionGroup.Vertical,
              textElements: [
                TextElement(
                    label: "name"
                ),
                TextElement(
                    label: "password",
                    typeInput: TypeInput.Password
                )
              ]
          )
        ],
      ),
    );
  }

}
