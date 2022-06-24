import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/wallet_api.dart';
import 'package:wallet_uwu/pages/wallet/qrcode_page.dart';
import 'package:wallet_uwu/pages/wallet/transfer_page.dart';

import '../../provider/access_token.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey();

  Widget cardTransfer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black12,
            )
          ],
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.compare_arrows,
                    size: 35,
                    color: Colors.grey.shade600,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "Sesama ",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                  TextSpan(
                    text: "Kantongku",
                    style: TextStyle(
                        fontFamily: "ReggaeOne",
                        fontSize: 17,
                        color: Colors.deepPurple.shade900),
                  )
                ]))
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10), topEnd: Radius.circular(10)),
            ),
            width: double.infinity,
            height: 60,
          ),
          const DottedLine(
            dashColor: Colors.black26,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/transfer');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text.rich(TextSpan(
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Poppins"),
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.compare_arrows,
                              size: 18,
                              color: Colors.white,
                            )),
                            TextSpan(text: "  Transfer")
                          ])),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      qrGenerate();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text.rich(TextSpan(
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Poppins"),
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.qr_code,
                              size: 18,
                              color: Colors.white,
                            )),
                            TextSpan(text: "  QR Saya")
                          ])),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple)),
                  ),
                )
              ],
            ),
            width: double.infinity,
            height: 60,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Text(
          "Transfer Uang",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [cardTransfer()],
          ),
        ),
      ),
    );
  }

  Future qrScanner() async {
    await FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ffffff", "Cancel", true, ScanMode.QR)
        ?.listen((barcode) {
      print(barcode.toString());
    });
  }

  Future qrGenerate() async {
    final provider = Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response =
          await WalletApi().getInfoQR(provider.tokenAuth.tokenAccess);

      if (response['statusCode'] != 200) {
        provider.updateToken();
        qrGenerate();
      } else {
        Navigator.of(context)
            .pushNamed('/qr_code', arguments: response['qrInfo']);
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terhubung Server", backgroundColor: Colors.black87);
    }
  }
}
