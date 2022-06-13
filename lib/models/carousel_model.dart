import 'dart:convert';

class GetDataBanner {
  GetDataBanner({
    required this.statusCode,
    required this.message,
    this.listData,
  });

  int statusCode;
  String message;
  List<CarouselModel>? listData;

  factory GetDataBanner.fromJson(Map<String, dynamic> json) => GetDataBanner(
        statusCode: json["statusCode"],
        message: json["message"],
        listData: json.containsKey('listData')
            ? List<CarouselModel>.from(
                json["listData"].map((x) => CarouselModel.fromJson(x)))
            : [],
      );
}

class CarouselModel {
  CarouselModel({
    required this.id,
    required this.bannerNama,
    required this.bannerFile,
  });

  int id;
  String bannerNama;
  String bannerFile;

  factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        id: json["id"],
        bannerNama: json["banner_nama"],
        bannerFile: json["banner_file"],
      );
}
