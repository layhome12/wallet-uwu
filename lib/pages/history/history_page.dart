import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_uwu/api/wallet_api.dart';

import '../../models/history_model.dart';
import 'package:provider/provider.dart';

import '../../provider/access_token.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> historyTransaction = [];
  String transactionCode = "";

  @override
  void initState() {
    getHistoryTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "History Transaksi",
          style: TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: ListView.builder(
              itemCount: historyTransaction.length,
              itemBuilder: (context, index) {
                String title = historyTransaction[index].transaksiType == 1
                    ? 'Top Up'
                    : 'Transfer';
                IconData icon = historyTransaction[index].transaksiType == 1
                    ? Icons.add_card_outlined
                    : Icons.account_tree_outlined;
                String date = historyTransaction[index]
                    .createdAt
                    .replaceAll(".000Z", "")
                    .replaceAll("T", " ");
                String status = historyTransaction[index].transaksiStatus == 2
                    ? 'Berhasil'
                    : 'Pending';
                Color color = historyTransaction[index].transaksiStatus == 2
                    ? Colors.deepPurple
                    : Colors.orange;
                return InkWell(
                  onTap: () {
                    setState(() {
                      transactionCode = historyTransaction[index].transaksiCode;
                    });
                    if (historyTransaction[index].transaksiType == 1) {
                      showDetailTopUp();
                    } else {
                      showDetailTransfer();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: Icon(
                        icon,
                        size: 30,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(fontFamily: "Poppins"),
                      ),
                      subtitle: Text(
                        date,
                        style: const TextStyle(
                            fontFamily: "Poppins", fontSize: 12),
                      ),
                      trailing: Text(
                        status,
                        style: TextStyle(fontFamily: "Poppins", color: color),
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              })),
    );
  }

  void getHistoryTransaction() async {
    final authProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response = await WalletApi()
          .historyTransaksi(authProvider.tokenAuth.tokenAccess);

      if (response.statusCode != 200) {
        authProvider.updateToken();
        getHistoryTransaction();
      } else {
        setState(() {
          historyTransaction = response.listData;
        });
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Dapat Terhubung Server", backgroundColor: Colors.black54);
    }
  }

  void showDetailTopUp() async {
    final authProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response = await WalletApi().historyDetailTopUp(
          authProvider.tokenAuth.tokenAccess, transactionCode);
      if (response['statusCode'] != 200) {
        authProvider.updateToken();
        showDetailTopUp();
      } else {
        String dataResponse = json.encode(response["data"]);
        Navigator.of(context)
            .pushNamed('/topup_success', arguments: dataResponse);
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terhubung Server", backgroundColor: Colors.black54);
    }
  }

  void showDetailTransfer() async {
    final authProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response = await WalletApi().historyDetailTransfer(
          authProvider.tokenAuth.tokenAccess, transactionCode);
      if (response['statusCode'] != 200) {
        authProvider.updateToken();
        showDetailTransfer();
      } else {
        String dataResponse = json.encode(response["data"]);
        Navigator.of(context)
            .pushNamed('/success_transfer', arguments: dataResponse);
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terhubung Server", backgroundColor: Colors.black54);
    }
  }
}
