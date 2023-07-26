import 'package:flutter/material.dart';

class DiyHelpListingModel {
  int? id;
  String? userType;
  int? userId;
  String? title;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;
  bool? isExpand;
  List<Comments>? comments;
  List<String>? images;

  DiyHelpListingModel(
      {this.id,
      this.images,
      this.userType,
      this.userId,
      this.title,
      this.isExpand,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic,
      this.comments});

  static List<DiyHelpListingModel> fromSnapshot(List snapshot) {
    return snapshot.map((snap) => DiyHelpListingModel.fromJson(snap)).toList();
  }

  DiyHelpListingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['diyhelpimages'] == null
        ? []
        : json['diyhelpimages'].cast<String>();
    isExpand = false;
    userType = json['user_type'];
    userId = json['user_id'];
    title = json['title'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['title'] = title;
    data['comment'] = comment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? diyHelpCommentId;
  String? userType;
  int? diyHelpId;
  int? userId;
  String? comment;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;
  bool? isReplyExpand;
  TextEditingController? controller;
  List<Replies>? replies;

  Comments(
      {this.id,
      this.diyHelpCommentId,
      this.userType,
      this.diyHelpId,
      this.controller,
      this.userId,
      this.comment,
      this.status,
      this.createdAt,
      this.isReplyExpand,
      this.updatedAt,
      this.name,
      this.profilePic,
      this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    controller = TextEditingController();
    isReplyExpand = false;
    diyHelpCommentId = json['diy_help_comment_id'];
    userType = json['user_type'];
    diyHelpId = json['diy_help_id'];
    userId = json['user_id'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diy_help_comment_id'] = diyHelpCommentId;
    data['user_type'] = userType;
    data['diy_help_id'] = diyHelpId;
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
  int? diyHelpCommentId;
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
      this.diyHelpCommentId,
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
    diyHelpCommentId = json['diy_help_comment_id'];
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
    data['diy_help_comment_id'] = diyHelpCommentId;
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
