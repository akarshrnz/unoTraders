class TraderQuoteReqModel {
  String? traderId;
  String? name;
  String? profilePic;
  String? quoteId;
  String? quoteReason;
  String? quotedPrice;
  String? status;

  TraderQuoteReqModel(
      {this.traderId,
      this.name,
      this.quoteId,
      this.profilePic,
      this.quoteReason,
      this.quotedPrice,
      this.status});

  TraderQuoteReqModel.fromJson(Map<String, dynamic> json) {
    traderId = json['trader_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    quoteId = json['quote_id'];
    quoteReason = json['quote_reason'];
    quotedPrice = json['quoted_price'];
    status = json['status'];
  }
  static List<TraderQuoteReqModel> fromSnapshot(List snapshot) {
    return snapshot.map((snap) => TraderQuoteReqModel.fromJson(snap)).toList();
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['trader_id'] = this.traderId;
  //   data['name'] = this.name;
  //   data['quote_id'] = this.quoteId;
  //   data['quote_reason'] = this.quoteReason;
  //   data['quoted_price'] = this.quotedPrice;
  //   data['status'] = this.status;
  //   return data;
  // }
}
