class CustomerQuoteActionModel {
  String? jobquoteId;
  String? userType;
  String? userId;
  String? status;

  CustomerQuoteActionModel(
      {this.jobquoteId, this.userType, this.userId, this.status});

  CustomerQuoteActionModel.fromJson(Map<String, dynamic> json) {
    jobquoteId = json['jobquoteId'];
    userType = json['userType'];
    userId = json['userId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobquoteId'] = jobquoteId;
    data['userType'] = userType;
    data['userId'] = userId;
    data['status'] = status;
    return data;
  }
}
