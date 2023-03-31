class FollowListModel {
  int? id;
  String? userType;
  int? userId;
  int? traderId;
  int? follow;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  String? name;

  FollowListModel(
      {this.id,
      this.userType,
      this.profilePic,
      this.name,
      this.userId,
      this.traderId,
      this.follow,
      this.createdAt,
      this.updatedAt});
  static List<FollowListModel> snapshot(List snapshot) {
    return snapshot.map((snap) => FollowListModel.fromJson(snap)).toList();
  }

  FollowListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    follow = json['follow'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['follow'] = follow;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
