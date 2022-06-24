import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/auth_model.dart';
import 'package:wallet_uwu/models/response_server.dart';

class AuthApi {
  final baseUrl = 'http://192.168.2.4:8081/api/';
  final _storageCookie = const FlutterSecureStorage();

  Future authLogin(String username, String password) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + 'auth'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"username": username, "password": password}),
        )
        .timeout(const Duration(seconds: 5));

    //Get Cookie Token
    if (response.statusCode == 200) {
      getCookieAuth(response);
    }

    return AuthModel.fromJson(jsonDecode(response.body));
  }

  void getCookieAuth(http.Response response) async {
    var cookieAuth = '';
    final rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookieAuth = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      cookieAuth = cookieAuth.replaceAll("refreshToken=", "");

      await _storageCookie.write(key: 'refreshToken', value: cookieAuth);
    }
  }

  Future refreshingToken() async {
    var cookie = await _storageCookie.read(key: 'refreshToken');

    final response = await http
        .post(
          Uri.parse(baseUrl + 'auth/refresh'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"refresh_token": cookie!}),
        )
        .timeout(const Duration(seconds: 5));

    return AuthModel.fromJson(jsonDecode(response.body));
  }

  Future forgotPassword(String email) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + "forgot_password"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email}),
        )
        .timeout(const Duration(seconds: 5));

    return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
  }

  Future verifyPasswordOtp(String otp, String token) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + "forgot_password/verify"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              "verify_token": token,
              "otp_code": otp,
            },
          ),
        )
        .timeout(const Duration(seconds: 5));

    return VerifyPasswordResponse.fromJson(jsonDecode(response.body));
  }

  Future resetPassword(String token, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + "forgot_password/reset"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "key_pass": token,
        "new_password": password
      }),
    ).timeout(const Duration(seconds: 5));
    
    return ResponseServer.fromJson(json.decode(response.body));
  }
}
