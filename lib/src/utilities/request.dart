import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

enum requestType {
  get,
  post,
}

Future<T> request<T>(String url, T Function(dynamic) mapReq,
    {requestType type = requestType.get, Map body}) async {
  http.Client client = http.Client();
  http.Response response;
  if (type == requestType.get) {
    response = await client.get(url);
  } else {
    response = await client.post(url, body: body);
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
  var _list =
      (jsonResponse as List).map((j) => mapReq(j as Map<String,dynamic>)).toList(); //_Country.fromJson(j)
  return _list;
}
