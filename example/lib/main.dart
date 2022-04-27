import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:formdynamic/login_page.dart';

import 'payment_example.dart';

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
    tabController = TabController(
      length: 3,
      initialIndex: 1,
      vsync: this,
    );
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
                child: Text("Login form "),
              ),
              GestureDetector(
                onTap: () {
                  tabController.index = 2;
                },
                child: Text("payment form "),
              ),
            ],
          ),
          actions: [],
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            MyHomePage(),
            LoginPage(),
            PaymentExample(),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // controller.clearValues()
  @override
  Widget build(BuildContext context) {
    final controller = FormController();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SimpleDynamicForm(
                controller: controller,
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
                      TextElement(
                          label: "last name",
                          isRequired: true,
                          initValue: "your name",
                          validator: (v) {
                            if (v != "your name") {
                              return "name not accepted";
                            }
                            return null;
                          }),
                    ],
                  ),
                  GroupElement(
                    directionGroup: DirectionGroup.Vertical,
                    textElements: [
                      SelectChoiceElement(
                        values: ["Male","Female"],
                        initValue: "Male",
                        label: "Gender",
                        id: "gender",
                        decorationElement: OutlineDecorationElement()
                      ),
                      PhoneNumberElement(
                        //label: "",
                        hint: "Phone Number",
                        errorMsg: "invalid phone number",
                        initValue: "1234567",
                        showPrefix: true,
                        showPrefixFlag: true,
                        readOnly: false,
                        visibility: false,
                        decorationElement: OutlineDecorationElement(
                          borderColor: Colors.grey,
                        ),
                      ),
                      DateElement(
                        id: "date",
                        hint: "date",
                        label: "date",
                        isRequired: true,
                        errorMsg: "this field is required",
                      ),
                      TextElement(
                        label: "last name",
                        isRequired: true,
                        initValue: "your name",
                        error: "this field is required",
                        validator: (v) {
                          if (v != "your name") {
                            return "name not accepted";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  GroupElement(
                    directionGroup: DirectionGroup.Vertical,
                    commonDecorationElements: OutlineDecorationElement(
                      contentPadding: EdgeInsets.only(left: 5, right: 3),
                      radius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    textElements: [
                      CountryElement(
                        id: "countries",
                        label: "Pays",
                        labelModalSheet: "Pays",
                        labelSearchModalSheet: "search",
                        // decorationElement: OutlineDecorationElement(
                        //   radius: BorderRadius.circular(4),
                        // ),
                        initValue: "",
                        countryTextResult: CountryTextResult.countryCode,
                        showFlag: true,
                      ),
                      PhoneNumberElement(
                        label: "Phone",
                        showPrefix: true,
                        showSuffixFlag: true,
                        showPrefixFlag: false,
                        hint: "Phone",
                        initPrefix: "+216",
                      ),
                      TextAreaElement(
                        maxCharacter: 300,
                        maxLines: 4,
                        showCounter: false,
                      ),
                    ],
                  ),
                ],
                submitButton: SubmitForm(),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 8,
          child: FloatingActionButton(
            heroTag: "clearForm",
            child: Icon(Icons.delete),
            onPressed: () => controller.clearValues(),
          ),
        ),
      ],
    );
  }
}

class SubmitForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = SimpleDynamicForm.of(context);
    return ElevatedButton(
      onPressed: () {
        print(controller.validate());
        print(controller.getAllValues());
        print(controller.getAllValuesByIds());
        print(controller.getValueById("countries"));
      },
      child: Text("Validate"),
    );
  }
}
