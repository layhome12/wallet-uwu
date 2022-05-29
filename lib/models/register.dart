class Register {
  Register({required this.statusCode, required this.message, this.verifyToken});

  int statusCode;
  String message;
  String? verifyToken;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      statusCode: json["statusCode"],
      message: json["message"],
      verifyToken: json.containsKey("verifyToken") ? json["verifyToken"] : '');

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "verifyToken": verifyToken
      };
}
