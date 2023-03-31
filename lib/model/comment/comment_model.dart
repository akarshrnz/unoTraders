class CommentModel {
  int? id;
  int? commentId;
  int? mainId;
  String? userType;
  int? userId;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? traderId;
  String? profilePic;
  List<Replies>? replies;

  CommentModel(
      {this.id,
      this.commentId,
      this.mainId,
      this.userType,
      this.userId,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.traderId,
      this.name,
      this.profilePic,
      this.replies});

  static List<CommentModel> snapshot(List snapshot) {
    return snapshot.map((snap) => CommentModel.fromJson(snap)).toList();
  }

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['comment_id'];
    mainId = json['main_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    traderId = json['trader_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment_id'] = commentId;
    data['main_id'] = mainId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  int? commentId;
  int? mainId;
  String? userType;
  int? userId;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;

  Replies(
      {this.id,
      this.commentId,
      this.mainId,
      this.userType,
      this.userId,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['comment_id'];
    mainId = json['main_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment_id'] = commentId;
    data['main_id'] = mainId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    return data;
  }
}
