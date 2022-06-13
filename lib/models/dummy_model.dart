// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DummyModel welcomeFromJson(String str) => DummyModel.fromJson(json.decode(str));

String welcomeToJson(DummyModel data) => json.encode(data.toJson());

class DummyModel {
  DummyModel({
    required this.statusCode,
    required this.message,
    this.listData,
  });

  int statusCode;
  String message;
  List<ListData>? listData;

  factory DummyModel.fromJson(Map<String, dynamic> json) => DummyModel(
        statusCode: json["statusCode"],
        message: json["message"],
        listData: (json.containsKey("listData"))
            ? List<ListData>.from(
                json["listData"].map((x) => ListData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "listData": List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}

class ListData {
  ListData({
    required this.id,
    required this.dummyName,
  });

  int id;
  String dummyName;

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        id: json["id"],
        dummyName: json["dummy_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dummy_name": dummyName,
      };
}
