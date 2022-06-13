import 'package:flutter/material.dart';
import 'package:wallet_uwu/api/auth_api.dart';
import 'package:wallet_uwu/models/auth_model.dart';

class AccessTokenProvider with ChangeNotifier {
  AuthModel authModel =
      AuthModel(statusCode: 404, message: "Token is Empty", tokenAccess: "");

  AuthModel get tokenAuth => authModel;

  void updateToken() async {
    await AuthApi().refreshingToken().then((value) => {
          authModel.statusCode = value.statusCode,
          authModel.message = value.message,
          authModel.tokenAccess = value.tokenAccess
        });

    notifyListeners();
  }

  void createToken(int statusCode, String message, String tokenAccess) {
    authModel.statusCode = statusCode;
    authModel.message = message;
    authModel.tokenAccess = tokenAccess;

    notifyListeners();
  }
}
