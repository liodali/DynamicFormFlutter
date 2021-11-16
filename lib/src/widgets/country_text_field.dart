import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/src/utilities/constants.dart';
import 'package:dynamic_form/src/utilities/request.dart';
import 'package:dynamic_form/src/widgets/flag_country.dart';
import 'package:flutter/material.dart';

class _Country {
  final String? fullName;
  final String? countryCode;
  final String? code2Alpha;

  _Country({this.fullName, this.countryCode, this.code2Alpha});

  _Country.fromJson(Map<String, dynamic> map)
      : this.fullName = map["name"],
        this.countryCode = map["alpha3Code"],
        this.code2Alpha = map["alpha2Code"];

  @override
  int get hashCode {
    return this.fullName.hashCode ^ this.countryCode.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }

    return other is _Country &&
        this.fullName == other.fullName &&
        this.countryCode == other.countryCode;
  }
}

class CountryTextField extends StatefulWidget {
  final TextEditingController? textEditingController;

  final CountryTextResult countryTextResult;

  final CountryElement? element;

  CountryTextField({
    this.textEditingController,
    this.element,
    this.countryTextResult = CountryTextResult.FullName,
  });

  @override
  _CountryTextFieldState createState() => _CountryTextFieldState();
}

class _CountryTextFieldState extends State<CountryTextField> {
  _Country? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.element!.initValue!.isNotEmpty) {
      widget.textEditingController!.text = widget.element!.initValue!;
    }
  }

  /*
   label: element.label,
    errorMsg: element.errorMsg,
    labelModalSheet: element.labelModalSheet,
    labelSearchModalSheet: element.labelSearchModalSheet,
    initValue: element.initValue,
    showFlag: element.showFlag,
   */
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      decoration: Constants.setInputBorder(context, widget.element!.decorationElement).copyWith(
        labelText: widget.element!.label,
        labelStyle: TextStyle(color: Colors.black),
        hintText: widget.element!.hint,
        //errorText: widget.element.errorMsg,
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return widget.element!.errorMsg;
        }
        return null;
      },
      readOnly: widget.element!.readOnly,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        if (!widget.element!.readOnly) {
          var selected = await showModalBottomSheet<_Country>(
              context: context,
              backgroundColor: Colors.white,
              isDismissible: false,
              isScrollControlled: false,
              builder: (ctx) {
                return _CountriesBottomSheet(
                  initialSelection: _selected,
                  initValue: widget.element!.initValue,
                  title: widget.element!.labelModalSheet,
                  labelRecherche: widget.element!.labelSearchModalSheet,
                  showFlag: widget.element!.showFlag,
                );
              });
          if (selected != null) {
            if (widget.countryTextResult == CountryTextResult.FullName)
              widget.textEditingController!.text = selected.fullName!;
            else
              widget.textEditingController!.text = selected.countryCode!;

            setState(() {
              _selected = selected;
            });
          }
        }
      },
    );
  }
}

class _CountriesBottomSheet extends StatefulWidget {
  final _Country? initialSelection;
  final String? initValue;
  final String? title;
  final String? labelRecherche;
  final bool showFlag;

  _CountriesBottomSheet({
    this.initialSelection,
    this.initValue,
    this.title,
    this.labelRecherche,
    this.showFlag = false,
  });

  @override
  State<StatefulWidget> createState() {
    return _CountriesBottomSheetState();
  }
}

class _CountriesBottomSheetState extends State<_CountriesBottomSheet> {
  Future<List<_Country?>?> loadCountries() async {
    _list = await getInformation<_Country?>((data) => _Country.fromJson(data));
    if (widget.initValue!.isNotEmpty && _selected == null) {
      _selected = _list!.firstWhere(
          (c) =>
              c!.fullName!.toLowerCase() == widget.initValue!.toLowerCase() ||
              c.countryCode!.toLowerCase() == widget.initValue!.toLowerCase(),
          orElse: () => null);
    }
    setState(() {});
    return _list;
  }

  List<_Country?>? _list;
  _Country? _selected;
  Stream<List<_Country?>?>? _stream;
  late ValueNotifier<bool> _notifierShowClose;
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _notifierShowClose = ValueNotifier(false);
    _searchController = TextEditingController(text: "");
    _searchController!.addListener(() async {
      if (_list!.isNotEmpty) {
        _notifierShowClose.value = true;
        var newList = _list!
            .where(
                (c) => c!.fullName!.toLowerCase().contains(_searchController!.text.toLowerCase()))
            .toList();
        _stream = Stream.value(newList);
      } else {
        Stream.value(_list);
      }
    });
    _stream = Stream.fromFuture(loadCountries());
    _selected = widget.initialSelection;
  }

  @override
  void dispose() {
    _stream = null;
    _searchController!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _selected);
        return true;
      },
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              widget.title!,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: null,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context, _selected);
                },
                iconSize: 32,
                color: Colors.black,
                icon: Icon(Icons.close),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            margin: EdgeInsets.only(bottom: 5.0),
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.black,
              enabled: true,
              decoration: InputDecoration(
                suffixIcon: Container(
                  width: 32,
                  height: 32,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _notifierShowClose,
                    builder: (ctx, show, child) {
                      if (show)
                        return InkWell(
                          onTap: () {
                            _searchController!.clear();
                            _notifierShowClose.value = false;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: child,
                        );
                      return Container();
                    },
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
                fillColor: Colors.grey[200],
                focusColor: Colors.black,
                filled: true,
                hintText: widget.labelRecherche,
                hintStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.all(5.0),
                //hoverColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<_Country?>?>(
              stream: _stream,
              builder: (ctx, snap) {
                if (snap.hasError) {
                  return ErrorWidget(snap.error!);
                }
                if (snap.hasData) {
                  var list = snap.data;
                  return DraggableScrollableSheet(
                    initialChildSize: 1.0,
                    maxChildSize: 1.0,
                    minChildSize: 1.0,
                    builder: (ctx, controller) {
                      return ListView.builder(
                        controller: ScrollController(
                            initialScrollOffset: list!.indexOf(_selected) != -1
                                ? 48.8 * (list.indexOf(_selected))
                                : 0.0),
                        addAutomaticKeepAlives: true,
                        itemExtent: 50.0,
                        itemBuilder: (ctx, i) {
                          return RadioListTile<_Country?>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            secondary: widget.showFlag
                                ? FlagCountry(
                                    countryName: list[i]!.code2Alpha ?? "",
                                  )
                                : null,
                            onChanged: (c) {
                              setState(() {
                                _selected = c;
                              });
                            },
                            groupValue: _selected,
                            title: Text("${list[i]!.fullName}"),
                            value: list[i],
                            selected: _selected == list[i],
                          );
                        },
                        itemCount: list.length,
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
