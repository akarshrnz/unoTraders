class TraderFeedModel {
  String? name;
  String? profilePic;
  int? id;
  int? traderId;
  String? title;
  String? postContent;
  int? status;
  String? emoji;
  String? likes;
  String? reactions;
  String? createdAt;
  String? updatedAt;
  List<String>? postImages;
  List<Traderpostimages>? traderpostimages;

  TraderFeedModel(
      {this.name,
      this.profilePic,
      this.id,
      this.traderId,
      this.title,
      this.postContent,
      this.status,
      this.emoji,
      this.likes,
      this.reactions,
      this.createdAt,
      this.updatedAt,
      this.postImages,
      this.traderpostimages});
  static List<TraderFeedModel> snapshot(List snapshot) {
    return snapshot.map((snap) => TraderFeedModel.fromJson(snap)).toList();
  }

  TraderFeedModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profile_pic'];
    id = json['id'];
    traderId = json['trader_id'];
    title = json['title'];
    postContent = json['post_content'];
    status = json['status'];
    emoji = json['emoji'];
    likes = json['likes'];
    reactions = json['reactions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    postImages = json['post_images'].cast<String>();
    if (json['traderpostimages'] != null) {
      traderpostimages = <Traderpostimages>[];
      json['traderpostimages'].forEach((v) {
        traderpostimages!.add(new Traderpostimages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_pic'] = profilePic;
    data['id'] = id;
    data['trader_id'] = traderId;
    data['title'] = title;
    data['post_content'] = postContent;
    data['status'] = status;
    data['emoji'] = emoji;
    data['likes'] = likes;
    data['reactions'] = reactions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['post_images'] = postImages;
    if (traderpostimages != null) {
      data['traderpostimages'] =
          traderpostimages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Traderpostimages {
  int? id;
  int? traderPostId;
  String? postImage;
  String? createdAt;
  String? updatedAt;

  Traderpostimages(
      {this.id,
      this.traderPostId,
      this.postImage,
      this.createdAt,
      this.updatedAt});

  Traderpostimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderPostId = json['trader_post_id'];
    postImage = json['post_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_post_id'] = traderPostId;
    data['post_image'] = postImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
// class TraderFeedModel {
//   int? id;
//   int? traderId;
//   String? title;
//   String? postContent;
//   int? status;
//   String? emoji;
//   String? likes;
//   String? reactions;
//   String? createdAt;
//   String? updatedAt;
//   List<String>? postImages;
//   List<Traderpostimages>? traderpostimages;

//   TraderFeedModel(
//       {this.id,
//       this.traderId,
//       this.title,
//       this.postContent,
//       this.status,
//       this.emoji,
//       this.likes,
//       this.reactions,
//       this.createdAt,
//       this.updatedAt,
//       this.postImages,
//       this.traderpostimages});

//   static List<TraderFeedModel> snapshot(List snapshot) {
//     return snapshot.map((snap) => TraderFeedModel.fromJson(snap)).toList();
//   }

//   TraderFeedModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderId = json['trader_id'];
//     title = json['title'];
//     postContent = json['post_content'];
//     status = json['status'];
//     emoji = json['emoji'];
//     likes = json['likes'];
//     reactions = json['reactions'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     postImages = json['post_images'].cast<String>();
//     if (json['traderpostimages'] != null) {
//       traderpostimages = <Traderpostimages>[];
//       json['traderpostimages'].forEach((v) {
//         traderpostimages!.add(Traderpostimages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_id'] = traderId;
//     data['title'] = title;
//     data['post_content'] = postContent;
//     data['status'] = status;
//     data['emoji'] = emoji;
//     data['likes'] = likes;
//     data['reactions'] = reactions;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['post_images'] = postImages;
//     if (traderpostimages != null) {
//       data['traderpostimages'] =
//           traderpostimages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Traderpostimages {
//   int? id;
//   int? traderPostId;
//   String? postImage;
//   String? createdAt;
//   String? updatedAt;

//   Traderpostimages(
//       {this.id,
//       this.traderPostId,
//       this.postImage,
//       this.createdAt,
//       this.updatedAt});

//   Traderpostimages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderPostId = json['trader_post_id'];
//     postImage = json['post_image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_post_id'] = traderPostId;
//     data['post_image'] = postImage;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
