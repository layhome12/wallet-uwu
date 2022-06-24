import 'package:flutter/material.dart';

class WalletAmmountProvider with ChangeNotifier {
  String saldoAmmount = "0";

  String get walletAmmount => saldoAmmount;

  void changeSaldo(String saldo) {
    this.saldoAmmount = saldo;
    notifyListeners();
  }
}
