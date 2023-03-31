class BazaarDetailPostModel {
  int? userId;
  String? userType;
  int? productId;

  BazaarDetailPostModel({this.userId, this.userType, this.productId});

  BazaarDetailPostModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['product_id'] = productId;
    return data;
  }

  static List<BazaarDetailPostModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => BazaarDetailPostModel.fromJson(snap))
        .toList();
  }
}
