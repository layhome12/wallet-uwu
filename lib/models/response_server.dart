import 'dart:convert';

ResponseServer responseFromJson(String str) =>
    ResponseServer.fromJson(json.decode(str));

String responseToJson(ResponseServer data) => json.encode(data.toJson());

class ResponseServer {
  ResponseServer({required this.statusCode, required this.message});

  int statusCode;
  String message;

  factory ResponseServer.fromJson(Map<String, dynamic> json) =>
      ResponseServer(statusCode: json["statusCode"], message: json["message"]);

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
