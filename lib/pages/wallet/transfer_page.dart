import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/theme_helper.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController tujuanTransfer = TextEditingController();
  TextEditingController nominalTransfer = TextEditingController();
  TextEditingController catatanTransfer = TextEditingController();

  Widget inputTujuanForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)]),
      child: TextFormField(
        controller: tujuanTransfer,
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
        keyboardType: TextInputType.number,
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

  Widget inputCatatanForm() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins"),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        minLines: 4,
        maxLines: 4,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
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
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 45,
                    color: Colors.deepPurple.shade700,
                  ),
                  padding: EdgeInsets.only(left: 10, right: 20),
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
                        style: TextStyle(fontFamily: "Poppins"),
                        children: [
                          TextSpan(text: "Saldo : "),
                          TextSpan(
                            text: "500.000",
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Ke Sesama Kantongku",
            style: TextStyle(
                color: Colors.white, fontFamily: "Poppins", fontSize: 18),
          ),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                        BoxShadow(blurRadius: 12, color: Colors.black12)
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
                      Navigator.of(context)
                          .pushReplacementNamed('/success_transfer');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
