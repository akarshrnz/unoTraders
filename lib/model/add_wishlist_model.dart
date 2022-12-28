class AddWishListModel {
  String? userType;
  int? userId;
  int? productId;

  AddWishListModel({this.userType, this.userId, this.productId});

  AddWishListModel.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = userType;
    data['userId'] = userId;
    data['productId'] = productId;
    return data;
  }
}