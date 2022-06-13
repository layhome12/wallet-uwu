class AuthModel {
  int statusCode;
  String message;
  String tokenAccess;

  AuthModel({required this.statusCode, required this.message, required this.tokenAccess});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        statusCode: json["statusCode"],
        message: json["message"],
        tokenAccess:
            json.containsKey("token_access") ? json["token_access"] : '',
      );
}
