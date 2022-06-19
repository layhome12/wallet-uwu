import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var encryptId = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Text(
          "QR Code Saya",
          style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "QR Code",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Tunjukan ini untuk wallet ke sesama Kantongku",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 13),
                          ),
                        )
                      ],
                    )),
                QrImage(
                  data: encryptId.toString(),
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
