class GetDataBerita {
  int statusCode;
  String message;
  List<BeritaModel>? listData;

  GetDataBerita(
      {required this.statusCode, required this.message, this.listData});

  factory GetDataBerita.fromJson(Map<String, dynamic> json) => GetDataBerita(
      statusCode: json['statusCode'],
      message: json['message'],
      listData: json.containsKey('listData')
          ? List<BeritaModel>.from(
              json['listData'].map((x) => BeritaModel.fromJson(x)))
          : []);
}

class BeritaModel {
  int id;
  String beritaImg;
  String beritaNama;
  String beritaSeo;
  String beritaIsi;

  BeritaModel(
      {required this.id,
      required this.beritaImg,
      required this.beritaNama,
      required this.beritaSeo,
      required this.beritaIsi});

  factory BeritaModel.fromJson(Map<String, dynamic> json) => BeritaModel(
        id: json['id'],
        beritaImg: json['berita_img'],
        beritaNama: json['berita_nama'],
        beritaSeo: json['berita_seo'],
        beritaIsi: json.containsKey('berita_isi') ? json['berita_isi'] : "",
      );
}
