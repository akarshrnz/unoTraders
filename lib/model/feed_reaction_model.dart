class FeedReactionModel {
  String? userType;
  int? userId;
  int? traderPostId;
  int? traderOfferId;
  String? dataReaction;

  FeedReactionModel(
      {this.userType,
      this.userId,
      this.traderPostId,
      this.dataReaction,
      this.traderOfferId});

  FeedReactionModel.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    userId = json['user_id'];
    traderPostId = json['trader_post_id'];
    traderOfferId = json['trader_offer_id'];
    dataReaction = json['data_reaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_post_id'] = traderPostId;
    data['trader_offer_id'] = traderOfferId;
    data['data_reaction'] = dataReaction;
    return data;
  }
}
//reaction parameters

// enum ReactionKeyword { "Like", "Angry", "Love", "HaHa", "Wow", "Sad" }

List<String> reactionKeyword = ["Like", "Love", "HaHa", "Angry", "Sad", "Wow"];
List<String> reactionIcon = [
  "assets/image/like.svg",
  "assets/image/heart.svg",
  "assets/image/laughing.svg",
  "assets/image/angry.svg",
  "assets/image/sad.svg",
  "assets/image/wow.svg",
];

String currentReaction(String emoji) {
  if (emoji.toLowerCase() == reactionKeyword[0].toLowerCase()) {
    return reactionIcon[0];
  } else if (emoji.toLowerCase() == reactionKeyword[1].toLowerCase()) {
    return reactionIcon[1];
  } else if (emoji.toLowerCase() == reactionKeyword[2].toLowerCase()) {
    return reactionIcon[2];
  } else if (emoji.toLowerCase() == reactionKeyword[3].toLowerCase()) {
    return reactionIcon[3];
  } else if (emoji.toLowerCase() == reactionKeyword[4].toLowerCase()) {
    return reactionIcon[4];
  } else {
    return reactionIcon[5];
  }
}
