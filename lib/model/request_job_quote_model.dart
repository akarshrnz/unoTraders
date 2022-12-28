class RequestJobQuoteModel {
  int? jobId;
  int? traderId;
  String? userType;
  int? userId;
  String? quotePrice;
  String? quoteReason;
  String? name;

  RequestJobQuoteModel(
      {this.jobId,
      this.traderId,
      this.userType,
      this.userId,
      this.quotePrice,
      this.quoteReason,
      this.name});

  RequestJobQuoteModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    traderId = json['trader_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    quotePrice = json['quote_price'];
    quoteReason = json['quote_reason'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['trader_id'] = traderId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['quote_price'] = quotePrice;
    data['quote_reason'] = quoteReason;
    data['name'] = name;
    return data;
  }
}
