class TraderReqMoreModel {
  int? jobId;
  int? jobQuoteId;
  int? jobQuoteDetailsId;
  String? userType;
  int? userId;
  int? traderId;
  String? requestDetails;

  TraderReqMoreModel(
      {this.jobId,
      this.jobQuoteId,
      this.jobQuoteDetailsId,
      this.userType,
      this.userId,
      this.traderId,
      this.requestDetails});

  TraderReqMoreModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobQuoteId = json['job_quote_id'];
    jobQuoteDetailsId = json['job_quote_details_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    requestDetails = json['request_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['job_quote_id'] = jobQuoteId;
    data['job_quote_details_id'] = jobQuoteDetailsId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['request_details'] = requestDetails;
    return data;
  }
}
