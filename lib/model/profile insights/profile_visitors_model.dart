class ProfileVisitorsModel {
  int? id;
  String? userType;
  int? userId;
  int? traderId;
  int? contacted;
  String? createdAt;
  String? updatedAt;
  String? name;

  ProfileVisitorsModel(
      {this.id,
      this.userType,
      this.userId,
      this.traderId,
      this.contacted,
      this.createdAt,
      this.updatedAt,
      this.name});

  ProfileVisitorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    contacted = json['contacted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['contacted'] = contacted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    return data;
  }

  static List<ProfileVisitorsModel> snapshot(List snapshot) {
    return snapshot.map((snap) => ProfileVisitorsModel.fromJson(snap)).toList();
  }
}
