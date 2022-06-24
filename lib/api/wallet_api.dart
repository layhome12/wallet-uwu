import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallet_uwu/models/history_model.dart';

class WalletApi {
  final baseUrl = 'http://192.168.2.4:8081/api/';

  Future getInfoQR(String bearer) async {
    final response = await http
        .get(Uri.parse(baseUrl + '/wallet/qr_info'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + bearer
    }).timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }

  Future topUpLocal(String bearer, int nominal) async {
    final response = await http
        .post(Uri.parse(baseUrl + '/wallet/topup'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + bearer
            },
            body: jsonEncode(<String, dynamic>{
              "nominal": nominal,
            }))
        .timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }

  Future transferLocal(
      String bearer, String tujuan, int nominal, String catatan) async {
    final response = await http
        .post(Uri.parse(baseUrl + '/wallet/transfer'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + bearer
            },
            body: jsonEncode(<String, dynamic>{
              "tujuan": tujuan,
              "nominal": nominal,
              "catatan": catatan != "" ? catatan : "-"
            }))
        .timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }

  Future historyTransaksi(String bearer) async {
    final response = await http
        .get(Uri.parse(baseUrl + "/wallet/history"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + bearer
    }).timeout(const Duration(seconds: 5));

    return GetDataHistory.formJson(json.decode(response.body));
  }

  Future historyDetailTopUp(String bearer, String code) async {
    final response = await http
        .post(Uri.parse(baseUrl + "/wallet/detail/topup"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + bearer
            },
            body: jsonEncode(<String, String>{'tr_code': code}))
        .timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }

  Future historyDetailTransfer(String bearer, String code) async {
    final response = await http
        .post(Uri.parse(baseUrl + "/wallet/detail/transfer"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + bearer
        },
        body: jsonEncode(<String, String>{'tr_code': code}))
        .timeout(const Duration(seconds: 5));

    return json.decode(response.body);
  }
}
