import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/wallet_api.dart';
import 'package:wallet_uwu/provider/access_token.dart';
import 'package:wallet_uwu/provider/wallet_ammount.dart';
import 'package:wallet_uwu/utils/validation.dart';

class TopUpLocalPage extends StatefulWidget {
  const TopUpLocalPage({Key? key}) : super(key: key);

  @override
  State<TopUpLocalPage> createState() => _TopUpLocalPageState();
}

class _TopUpLocalPageState extends State<TopUpLocalPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nominal = TextEditingController();
  int isActive = 0;

  Widget cardSaldo(String saldo) {
    return Container(
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
          Column(
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
                      text: saldo,
                      style: TextStyle(
                          fontFamily: "Digital7",
                          fontSize: 19,
                          color: Colors.deepPurple.shade700),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget pilihanNominalTransfer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isActive = 1;
              nominal.text = "100000";
            });
          },
          child: const Text(
            "Rp. 100.000",
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: (isActive == 1) ? Colors.deepPurple : Colors.white,
              onPrimary: (isActive == 1) ? Colors.white : Colors.black,
              side: const BorderSide(color: Colors.black12),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isActive = 2;
              nominal.text = "200000";
            });
          },
          child: const Text(
            "Rp. 200.000",
            style: TextStyle(fontFamily: "Poppins"),
          ),
          style: ElevatedButton.styleFrom(
              primary: (isActive == 2) ? Colors.deepPurple : Colors.white,
              onPrimary: (isActive == 2) ? Colors.white : Colors.black,
              side: const BorderSide(color: Colors.black12),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isActive = 3;
              nominal.text = "300000";
            });
          },
          child: const Text(
            "Rp. 300.000",
            style: TextStyle(fontFamily: "Poppins"),
          ),
          style: ElevatedButton.styleFrom(
              primary: (isActive == 3) ? Colors.deepPurple : Colors.white,
              onPrimary: (isActive == 3) ? Colors.white : Colors.black,
              side: const BorderSide(color: Colors.black12),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
        ),
      ],
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
        keyboardType: TextInputType.number,
        onTap: () {
          setState(() {
            isActive = 0;
          });
        },
        controller: nominal,
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Up Local",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Consumer<WalletAmmountProvider>(
                      builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: Text(
                            "Top Up Ke",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "ReggaeOne",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        cardSaldo(value.walletAmmount),
                      ],
                    );
                  })),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Text(
                          "Pilih Nominal Top Up",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "ReggaeOne",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      pilihanNominalTransfer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Atau masukkan nominal top up disini",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                        ),
                      ),
                      inputNominalForm()
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                child: ElevatedButton(
                  onPressed: () {
                    submittedForm();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Top Up',
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submittedForm() {
    if (formKey.currentState!.validate()) {
      sendTopUp();
    }
  }

  Future sendTopUp() async {
    final int nominalTopup = int.parse(nominal.text);
    final authProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response = await WalletApi()
          .topUpLocal(authProvider.tokenAuth.tokenAccess, nominalTopup);

      if (response['statusCode'] != 200) {
        authProvider.updateToken();
        sendTopUp();
      }else{
        String dataResponse=json.encode(response["data"]);
        Navigator.of(context).pushReplacementNamed('/topup_success',
            arguments: dataResponse);
      }

    } catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(), backgroundColor: Colors.black54);
    }
  }
}
