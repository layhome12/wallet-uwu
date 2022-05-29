import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/response_server.dart';
import '../models/register.dart';

class RegisterApi {
  final baseUrl = "http://192.168.0.2:8081/api/";

  Future<Register> responseTest() async {
    final response = await http.get(Uri.parse(baseUrl + 'register/test'));

    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load URL API');
    }
  }

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

    return Register.fromJson(jsonDecode(response.body));
  }

  Future verifikasiAkun(String token) async {
    final response = await http
        .post(
          Uri.parse(baseUrl + "register/verify"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'verify_token': token}),
        )
        .timeout(const Duration(seconds: 5));

    return ResponseServer.fromJson(jsonDecode(response.body));
  }
}
