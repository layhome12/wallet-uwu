class GetDataHistory {
  int statusCode;
  String message;
  List<HistoryModel>? listData;

  GetDataHistory(
      {required this.statusCode, required this.message, this.listData});

  factory GetDataHistory.formJson(Map<String, dynamic> json) => GetDataHistory(
        statusCode: json["statusCode"],
        message: json["message"],
        listData: json.containsKey("listData")
            ? List<HistoryModel>.from(
                json["listData"].map((x) => HistoryModel.fromJson(x)))
            : [],
      );
}

class HistoryModel {
  int transaksiType;
  int transaksiStatus;
  String transaksiCode;
  int transaksiAmmount;
  String createdAt;

  HistoryModel(
      {required this.transaksiType,
      required this.transaksiStatus,
      required this.transaksiCode,
      required this.transaksiAmmount,
      required this.createdAt});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
      transaksiType: json["transaksi_type_id"],
      transaksiStatus: json["transaksi_status_id"],
      transaksiCode: json["transaksi_code"],
      transaksiAmmount: json["transaksi_ammount"],
      createdAt: json["created_at"]);
}
