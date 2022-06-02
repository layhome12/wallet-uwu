import 'package:flutter/material.dart';

class RefreshTokenProvider with ChangeNotifier {
  Color coloris=Colors.white;

  Color get refreshingToken => coloris;

  void refreshTokenAuth(String token) {
    coloris=Colors.black;
    // data = token;
    notifyListeners();
  }
}
