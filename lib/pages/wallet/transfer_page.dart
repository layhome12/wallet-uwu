import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/wallet_api.dart';
import 'package:wallet_uwu/provider/access_token.dart';
import 'package:wallet_uwu/provider/wallet_ammount.dart';
import 'package:wallet_uwu/utils/validation.dart';

import '../../common/theme_helper.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController tujuanTransfer = TextEditingController();
  TextEditingController nominalTransfer = TextEditingController();
  TextEditingController catatanTransfer = TextEditingController();

  Widget inputTujuanForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]),
      child: TextFormField(
        controller: tujuanTransfer,
        validator: (val) => uValidator(value: val, isRequire: true),
        decoration: ThemeHelper().textInputDecorationIcon(
            'Masukkan nomor atau username', '', Icons.account_balance_wallet),
        style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
      ),
    );
  }

  Widget inputNominalForm() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5, bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.shade200),
      child: TextFormField(
        controller: nominalTransfer,
        keyboardType: TextInputType.number,
        validator: (val) => uValidator(value: val, isRequire: true),
        style: TextStyle(
            fontSize: 50,
            fontFamily: "Digital7",
            color: Colors.deepPurple.shade800),
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
            errorStyle: TextStyle(fontFamily: "Poppins")),
      ),
    );
  }

  Widget inputCatatanForm() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextFormField(
        controller: catatanTransfer,
        style: const TextStyle(fontFamily: "Poppins"),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        minLines: 4,
        maxLines: 4,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black26)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black26)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }

  Widget transferSaldo() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sumber Dana",
            style: TextStyle(fontFamily: "Poppins", fontSize: 13),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, bottom: 14),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 45,
                    color: Colors.deepPurple.shade700,
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 20),
                ),
                Consumer<WalletAmmountProvider>(
                    builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text("Kantongku",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "ReggaeOne",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(fontFamily: "Poppins"),
                          children: [
                            const TextSpan(text: "Saldo : "),
                            TextSpan(
                              text: value.saldoAmmount,
                              style: TextStyle(
                                  fontFamily: "Digital7",
                                  fontSize: 19,
                                  color: Colors.deepPurple.shade700),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          const Text(
            "Nominal Transfer",
            style: TextStyle(fontFamily: "Poppins", fontSize: 13),
          ),
          inputNominalForm(),
          const Text(
            "Catatan (Opsional)",
            style: TextStyle(fontFamily: "Poppins", fontSize: 13),
          ),
          inputCatatanForm()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            "Sesama Kantongku",
            style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
          ),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  inputTujuanForm(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 25),
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.black12)
                        ]),
                    child: Column(
                      children: [transferSaldo()],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Kirim Saldo',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Poppins",
                              color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      onPressed: () {
                        submittedForm();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submittedForm() {
    final saldoProvider =
        Provider.of<WalletAmmountProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      int currentSaldo =
          int.parse(saldoProvider.saldoAmmount.replaceAll(".", ""));
      int nominal = int.parse(nominalTransfer.text.replaceAll(".", ""));

      if (currentSaldo >= nominal) {
        sendTransfer();
      } else {
        Fluttertoast.showToast(
            msg: "Maaf Saldo Anda Tinggal $currentSaldo",
            backgroundColor: Colors.black54);
      }
    }
  }

  Future sendTransfer() async {
    final authProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      int nominal = int.parse(nominalTransfer.text.replaceAll(".", ""));
      final response = await WalletApi().transferLocal(
          authProvider.tokenAuth.tokenAccess,
          tujuanTransfer.text,
          nominal,
          catatanTransfer.text);

      if (response['statusCode'] == 200) {
        String dataResponse = json.encode(response["data"]);
        Navigator.of(context)
            .pushReplacementNamed('/success_transfer', arguments: dataResponse);
      } else if (response['statusCode'] == 404) {
        Fluttertoast.showToast(
            msg: response["message"], backgroundColor: Colors.black54);
      } else {
        authProvider.updateToken();
        sendTransfer();
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terhubung Server", backgroundColor: Colors.black54);
    }
  }
}
