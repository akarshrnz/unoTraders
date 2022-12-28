import 'dart:io';

class AddPostModel {
  int? traderId;
  String? postTitle;
  String? postContent;
  List<File>? postImages;

  AddPostModel(
      {this.traderId, this.postTitle, this.postContent, this.postImages});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    traderId = json['traderId'];
    postTitle = json['postTitle'];
    postContent = json['postContent'];
    postImages = json['postImages[]'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traderId'] = traderId;
    data['postTitle'] = postTitle;
    data['postContent'] = postContent;
    data['postImages[]'] = postImages;
    return data;
  }
}
