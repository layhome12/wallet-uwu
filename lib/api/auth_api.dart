import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/auth_model.dart';
import 'package:wallet_uwu/provider/refresh_token.dart';

class AuthApi with ChangeNotifier {
  final baseUrl = 'http://192.168.0.2:8081/api/';

  Future authLogin(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}),
    );

    //Get Cookie Token
    if (response.statusCode == 200) {
      getCookieAuth(response);
    }

    return AuthModel.fromJson(jsonDecode(response.body));
  }

  void getCookieAuth(http.Response response) {
    var cookieAuth = '';
    final rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookieAuth = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      cookieAuth = cookieAuth.replaceAll("refreshToken=", "");

      RefreshTokenProvider().refreshTokenAuth(cookieAuth.toString());
    }
  }
}
