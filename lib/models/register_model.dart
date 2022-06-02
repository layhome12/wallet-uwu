class RegisterModel {
  RegisterModel({required this.statusCode, required this.message, this.verifyToken});

  int statusCode;
  String message;
  String? verifyToken;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      statusCode: json["statusCode"],
      message: json["message"],
      verifyToken: json.containsKey("verifyToken") ? json["verifyToken"] : '');

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "verifyToken": verifyToken
      };
}
