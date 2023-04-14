class ReplyMoreDetailsModel {
  int? jobId;
  int? jobQuoteId;
  int? jobQuoteDetailsId;
  int? userId;
  String? userType;
  String? quoteDetails;

  ReplyMoreDetailsModel(
      {this.jobId,
      this.jobQuoteId,
      this.jobQuoteDetailsId,
      this.userId,
      this.userType,
      this.quoteDetails});

  ReplyMoreDetailsModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobQuoteId = json['job_quote_id'];
    jobQuoteDetailsId = json['job_quote_details_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    quoteDetails = json['quote_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['job_quote_id'] = jobQuoteId;
    data['job_quote_details_id'] = jobQuoteDetailsId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['quote_details'] = quoteDetails;
    return data;
  }
}
