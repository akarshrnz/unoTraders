class BlockedTraderModel {
  String? name;
  String? profilePic;
  String? blockedOn;
  int? traderId;

  BlockedTraderModel(
      {this.name, this.profilePic, this.blockedOn, this.traderId});

  BlockedTraderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    traderId = json['trader_id'];
    profilePic = json['profile_pic'];
    blockedOn = json['blocked_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_pic'] = profilePic;
    data['blocked_on'] = blockedOn;
    return data;
  }

  static List<BlockedTraderModel> snapshot(List snapshot) {
    return snapshot.map((snap) => BlockedTraderModel.fromJson(snap)).toList();
  }
}
