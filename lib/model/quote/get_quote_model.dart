class GetQuoteModel {
  int? jobId;
  int? traderId;
  String? userType;
  String? name;
  int? userId;

  GetQuoteModel(
      {this.jobId, this.traderId, this.userType, this.name, this.userId});

  GetQuoteModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    traderId = json['trader_id'];
    userType = json['user_type'];
    name = json['name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['trader_id'] = traderId;
    data['user_type'] = userType;
    data['name'] = name;
    data['user_id'] = userId;
    return data;
  }
}
