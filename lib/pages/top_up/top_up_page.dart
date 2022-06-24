import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/provider/wallet_ammount.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  Widget metodeCard(String namaCard, IconData icon) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.shade300)],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: Colors.deepPurple,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                namaCard,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios, size: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Up",
          style: TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade500,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 85,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/circle-abstract.jpg'),
                      fit: BoxFit.cover)),
              child: Consumer<WalletAmmountProvider>(
                  builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(TextSpan(
                        style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                        children: [
                          TextSpan(text: "Saldo Kantongku Cash : "),
                          TextSpan(
                              text: value.saldoAmmount,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Maksimal Saldo Kantongku Saat Ini Rp. 10.000.000",
                        style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                      ),
                    )
                  ],
                );
              }),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: const Text(
                "Pilih Metode",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "ReggaeOne",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/topup_local');
              },
              child: metodeCard('Top Up Local', Icons.local_atm_outlined),
            ),
            metodeCard('Transfer Bank', Icons.account_balance),
            metodeCard('Indomaret', Icons.storefront)
          ],
        ),
      ),
    );
  }
}
