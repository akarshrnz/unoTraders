class FeedReactionModel {
  String? userType;
  int? userId;
  int? traderPostId;
  String? dataReaction;

  FeedReactionModel(
      {this.userType, this.userId, this.traderPostId, this.dataReaction});

  FeedReactionModel.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    userId = json['user_id'];
    traderPostId = json['trader_post_id'];
    dataReaction = json['data_reaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_post_id'] = traderPostId;
    data['data_reaction'] = dataReaction;
    return data;
  }
}
//reaction parameters

enum ReactionKeyword { Like, Angry, Love, HaHa, Wow, Sad }
