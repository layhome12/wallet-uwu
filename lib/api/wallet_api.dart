import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletApi {
  final baseUrl = 'http://192.168.0.2:8081/api/';

  Future getInfoQR(String bearer) async {
    final response = await http
        .get(Uri.parse(baseUrl + '/wallet/qr_info'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + bearer
    }).timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }
}
