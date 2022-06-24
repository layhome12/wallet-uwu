import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/dummy_model.dart';

class DummyApi {
  final baseUrl = 'http://192.168.2.4:8081/api/';

  Future getDataDummy(String bearer) async {
    final response =
        await http.get(Uri.parse(baseUrl + '/dummy'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + bearer
    });

    return DummyModel.fromJson(jsonDecode(response.body));
  }
}
