import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/response_server.dart';
import '../models/register_model.dart';

class RegisterApi {
  final baseUrl = "http://192.168.2.4:8081/api/";

  Future registerSave(String firstName, String lastName, String username,
      String email, String phoneNumber, String password) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + 'register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'first_name': firstName,
            'last_name': lastName,
            'username': username,
            'email': email,
            'phone_number': phoneNumber,
            'password': password
          }),
        )
        .timeout(const Duration(seconds: 5));

    return RegisterModel.fromJson(jsonDecode(response.body));
  }

  Future verifikasiAkun(String token, String otp) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + "register/verify"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'verify_token': token, 'otp_code': otp}),
        )
        .timeout(const Duration(seconds: 5));

    return ResponseServer.fromJson(jsonDecode(response.body));
  }

  Future getDetailUser(String bearer) async {
    final response = await http
        .get(Uri.parse(baseUrl + "user/detail"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + bearer
    }).timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }
}
