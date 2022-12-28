

class WishListModel {
  int? id;
  String? categoryId;
  String? subCategoryId;
  String? product;
  String? price;
  String? description;
  String? status;
  String? productLocation;
  String? latitude;
  String? longitude;
  String? addedUsertype;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  List<String>? bazaarimages;

  WishListModel(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.product,
      this.price,
      this.description,
      this.status,
      this.productLocation,
      this.latitude,
      this.longitude,
      this.addedUsertype,
      this.addedBy,
      this.createdAt,
      this.updatedAt,
      this.bazaarimages});

  WishListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    productLocation = json['product_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addedUsertype = json['added_usertype'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bazaarimages = json['bazaarimages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['product'] = product;
    data['price'] = price;
    data['description'] = description;
    data['status'] = status;
    data['product_location'] = productLocation;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['added_usertype'] = addedUsertype;
    data['added_by'] = addedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bazaarimages'] = bazaarimages;
    return data;
  }

  static List<WishListModel> snapshot(List snapshot) {
    return snapshot.map((snap) => WishListModel.fromJson(snap)).toList();
  }
}
