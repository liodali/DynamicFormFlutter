import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:dynamic_form/src/utilities/request.dart';
import 'package:flutter/material.dart';

class _CallingCountry {
  final String fullName;
  final List<String> callingCode;

  _CallingCountry({this.fullName, this.callingCode});

  _CallingCountry.fromJson(Map<String, dynamic> map)
      : this.fullName = map["name"],
        this.callingCode =
            (map["callingCodes"] as List).map((c) => "+${c.trim()}").toList();

  @override
  int get hashCode {
    return this.fullName.hashCode ^ this.callingCode.hashCode;
  }

  @override
  bool operator ==(other) {
    _CallingCountry c = other;
    if (this.fullName == c.fullName && this.callingCode == c.callingCode) {
      return true;
    }
    return false;
  }
}

class PhoneTextField extends StatefulWidget {
  final PhoneNumberElement element;
  final TextEditingController controller;

  PhoneTextField({this.element, this.controller});

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: Constants.getInput(widget.element.typeInput),
      validator: widget.element.validator,
      readOnly: widget.element.readOnly,
      style: TextStyle(color: Colors.black),
      decoration:
          Constants.setInputBorder(context, widget.element.decorationElement)
              .copyWith(
        labelText: widget.element.label,
        hintText: widget.element.hint,
        prefix: widget.element.showPrefix
            ? SizedBox(
                width: 55,
                height: 25,
                child: PrefixPhoneNumber(
                  prefix: "",
                ),
              )
            : null,
      ),
    );
  }
}

class PrefixPhoneNumber extends StatefulWidget {
  final String prefix;
  final bool showFalg;

  PrefixPhoneNumber({this.prefix, this.showFalg = false});

  @override
  State<StatefulWidget> createState() => _PrefixPhoneNumberState();
}

class _PrefixPhoneNumberState extends State<PrefixPhoneNumber> {
  List<_CallingCountry> _list;
  Future<_CallingCountry> future;

  @override
  void initState() {
    super.initState();
    future = getCallingCode();
  }

  Future<_CallingCountry> getCallingCode() async {
    _list = await getInformation<_CallingCountry>(
      (data) => _CallingCountry.fromJson(data),
    );
    if (widget.prefix.isEmpty) {
      String callingCountries = await request<String>(
          "http://ip-api.com/json/", (jsonData) => jsonData["country"],
          type: requestType.get);
      if (callingCountries != null) {
        _CallingCountry _callingCountry = _list
            .where((value) =>
                value.fullName.toLowerCase() == callingCountries.toLowerCase())
            .first;
        return _callingCountry;
      }
      return _list.first;
    }
    return _CallingCountry(fullName: "", callingCode: [widget.prefix]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_CallingCountry>(
      future: future,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.hasError) {
            print(snap.error);
            return Container();
          }
          Widget textPrefix = Text("${snap.data.callingCode[0]}");
          return Row(
            children: <Widget>[
              if (widget.showFalg) ...[],
              textPrefix,
            ],
          );
        }
        return Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
