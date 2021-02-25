import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:dynamic_form/src/utilities/request.dart';
import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _CallingCountry {
  final String fullName;
  final String code3Alpha;
  final String code2Alpha;
  final List<String> callingCode;

  _CallingCountry({
    this.fullName,
    this.callingCode,
    this.code3Alpha,
    this.code2Alpha,
  });

  _CallingCountry.fromJson(Map<String, dynamic> map)
      : this.fullName = map["name"],
        this.code3Alpha = map["alpha3Code"],
        this.code2Alpha = map["alpha2Code"],
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
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final ValueNotifier<String> errorNotifier;

  PhoneTextField({
    this.element,
    this.controller,
    this.errorNotifier,
    this.currentFocus,
    this.nextFocus,
    Key key,
  }) : super(key: key);

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  ValueNotifier<_CallingCountry> countryNotifier;

  @override
  void initState() {
    super.initState();
    countryNotifier = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    Widget iconFlag = ValueListenableBuilder<_CallingCountry>(
      builder: (ctx, country, child) {
        if (country != null) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Flag(
              "${country.code2Alpha.toLowerCase()}",
              width: 12,
              height: 12,
            ),
          );
        }
        return Container();
      },
      valueListenable: countryNotifier,
    );
    if(widget.errorNotifier!=null){
      return ValueListenableBuilder<String>(
        valueListenable: widget.errorNotifier,
        builder: (ctx,error,child){
          return TextFormField(
            controller: widget.controller,
            keyboardType: Constants.getInput(widget.element.typeInput),
            validator: widget.element.validator,
            readOnly: widget.element.readOnly,
            style: TextStyle(color: Colors.black),
            focusNode: widget.currentFocus,
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            onFieldSubmitted: (v) {
              Constants.fieldFocusChange(
                  context, widget.currentFocus, widget.nextFocus);
            },
            decoration:
            Constants.setInputBorder(context, widget.element.decorationElement)
                .copyWith(
              labelText: widget.element.label,
              hintText: widget.element.hint,
              errorText: error,
              prefix: widget.element.showPrefix
                  ? SizedBox(
                width: 55,
                height: 25,
                child: PrefixPhoneNumber(
                  prefix: "",
                  countryNotifier: countryNotifier,
                ),
              )
                  : null,
              prefixIcon: widget.element.showPrefixFlag ? child : null,
              suffixIcon: widget.element.showSuffixFlag ? child : null,
            ),
          );
        },
        child: iconFlag,
      );
    }
    return TextFormField(
      controller: widget.controller,
      keyboardType: Constants.getInput(widget.element.typeInput),
      validator: widget.element.validator,
      readOnly: widget.element.readOnly,
      style: TextStyle(color: Colors.black),
      focusNode: widget.currentFocus,
      textInputAction: widget.nextFocus == null
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: (v) {
        Constants.fieldFocusChange(
            context, widget.currentFocus, widget.nextFocus);
      },
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
            countryNotifier: countryNotifier,
          ),
        )
            : null,
        prefixIcon: widget.element.showPrefixFlag ? iconFlag : null,
        suffixIcon: widget.element.showSuffixFlag ? iconFlag : null,
      ),
    );
  }
}

class PrefixPhoneNumber extends StatefulWidget {
  final String prefix;
  final ValueNotifier<_CallingCountry> countryNotifier;

  PrefixPhoneNumber({this.prefix, this.countryNotifier});

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
        widget.countryNotifier.value = _callingCountry;
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
            return Container();
          }
          return Text("${snap.data.callingCode[0]}");
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
