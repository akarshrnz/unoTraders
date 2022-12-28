class TraderRequestInfoModel {
  String? traderId;
  String? name;
  String? quoteId;
  String? quoteReason;
  String? quotedPrice;
  String? status;

  TraderRequestInfoModel(
      {this.traderId,
      this.name,
      this.quoteId,
      this.quoteReason,
      this.quotedPrice,
      this.status});

  TraderRequestInfoModel.fromJson(Map<String, dynamic> json) {
    traderId = json['trader_id'];
    name = json['name'];
    quoteId = json['quote_id'];
    quoteReason = json['quote_reason'];
    quotedPrice = json['quoted_price'];
    status = json['status'];
  }
  static List<TraderRequestInfoModel> jobSnapshot(List snapshot) {
    return snapshot
        .map((snap) => TraderRequestInfoModel.fromJson(snap))
        .toList();
  }
}
