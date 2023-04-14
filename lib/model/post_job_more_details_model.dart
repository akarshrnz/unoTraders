class PostJobMoreDetailsModel {
  int? jobId;
  int? userId;
  String? userType;
  int? offset;

  PostJobMoreDetailsModel(
      {this.jobId, this.userId, this.userType, this.offset});

  PostJobMoreDetailsModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['offset'] = offset;
    return data;
  }
}
