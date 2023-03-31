class BazaarDetailGetModel {
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
  int? wishlist;
  String? name;
  String? profilePic;
  List<RelatedProducts>? relatedProducts;
  List<String>? bazaarimages;

  BazaarDetailGetModel(
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
      this.wishlist,
      this.name,
      this.profilePic,
      this.relatedProducts,
      this.bazaarimages});

  BazaarDetailGetModel.fromJson(Map<String, dynamic> json) {
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
    wishlist = json['wishlist'];
    name = json['name'];
    profilePic = json['profile_pic'];
    if (json['related_products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['related_products'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
      });
    }
    bazaarimages = json['bazaarimages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['wishlist'] = wishlist;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (relatedProducts != null) {
      data['related_products'] =
          relatedProducts!.map((v) => v.toJson()).toList();
    }
    data['bazaarimages'] = bazaarimages;
    return data;
  }
}

class RelatedProducts {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? product;
  int? price;
  String? description;
  int? status;
  String? productLocation;
  double? latitude;
  double? longitude;
  String? addedUsertype;
  int? addedBy;
  String? createdAt;
  int? wishlist;
  String? updatedAt;
  List<String>? bazaarimages;

  RelatedProducts(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.product,
      this.price,
      this.description,
      this.status,
      this.productLocation,
      this.latitude,
      this.wishlist,
      this.longitude,
      this.addedUsertype,
      this.addedBy,
      this.createdAt,
      this.updatedAt,
      this.bazaarimages});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    wishlist = json['wishlist'];
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
}
