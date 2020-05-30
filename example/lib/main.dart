import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:formdynamic/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

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
          bottom: TabBar(
            controller: tabController,
            tabs: <Widget>[
              GestureDetector(
                onTap: () {
                  tabController.index = 0;
                },
                child: Text("Basic Example"),
              ),
              GestureDetector(
                onTap: () {
                  tabController.index = 1;
                },
                child: Text("Login form example"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            MyHomePage(),
            LoginPage(),
          ],
        ),
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
                  PhoneNumberElement(
                    label: "Phone Number",
                    hint: "XXXXXXXXX",
                    errorMsg: "invalid phone number",
                    showPrefix: true,
                    readOnly: false,
                    decorationElement: OutlineDecorationElement(
                      borderColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              GroupElement(
                directionGroup: DirectionGroup.Vertical,
                textElements: [
                  CountryElement(
                    label: "Pays",
                    labelModalSheet: "Pays",
                    labelSearchModalSheet: "search",
                    initValue: "",
                    countryTextResult: CountryTextResult.countryCode,
                    showFlag: false,
                  ),
                  TextAreaElement(
                    maxCharacter: 300,
                    maxLines: 4,
                    showCounter: false
                  )
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
