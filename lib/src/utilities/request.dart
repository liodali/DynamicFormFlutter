import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

enum requestType {
  get,
  post,
}

Future<T?> request<T>(
  String url,
  T Function(dynamic) mapReq, {
  requestType type = requestType.get,
      bool isJsonResponse = false,
  Map? body,
}) async {
  final uri = Uri.parse(url);
  http.Response response;
  if (type == requestType.get) {
    response = await http.get(uri);
  } else {
    response = await http.post(uri, body: body);
  }
  if (response.statusCode == 200)
    return mapReq(json.decode(response.body));
  else
    return null;
}

Future<List<T>> getInformation<T>(T Function(dynamic) mapReq) async {
  String jsonString = await rootBundle
      .loadString('packages/dynamic_form/assets/countries.json');
  final jsonResponse = json.decode(jsonString);
  var _list = (jsonResponse as List)
      .map((j) => mapReq(j as Map<String, dynamic>))
      .toList(); //_Country.fromJson(j)
  return _list;
}

class Address {
  final int FID;
  final String addr;

  Address(this.addr, this.FID);

  Address.fromMap(Map m)
      : this.addr = m["Adresse"],
        this.FID = m["FID"];
}
