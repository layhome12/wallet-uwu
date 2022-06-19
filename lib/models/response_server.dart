class ResponseServer {
  ResponseServer({required this.statusCode, required this.message});

  int statusCode;
  String message;

  factory ResponseServer.fromJson(Map<String, dynamic> json) => ResponseServer(
        statusCode: json["statusCode"],
        message: json["message"],
      );
}

class ForgotPasswordResponse {
  int statusCode;
  String message;
  String? verifyToken;

  ForgotPasswordResponse(
      {required this.statusCode, required this.message, this.verifyToken});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        verifyToken: json.containsKey("verifyToken") ? json["verifyToken"] : "",
      );
}

class VerifyPasswordResponse {
  int statusCode;
  String message;
  String? pwdReset;

  VerifyPasswordResponse(
      {required this.statusCode, required this.message, this.pwdReset});

  factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) =>
      VerifyPasswordResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        pwdReset: json.containsKey("pwdReset") ? json["pwdReset"] : "",
      );
}

class WalletAmmountResponse {
  int statusCode;
  String message;
  String? walletAmmount;

  WalletAmmountResponse(
      {required this.statusCode, required this.message, this.walletAmmount});

  factory WalletAmmountResponse.fromJson(Map<String, dynamic> json) =>
      WalletAmmountResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        walletAmmount:
            json.containsKey("walletAmmount") ? json["walletAmmount"] : "",
      );
}
