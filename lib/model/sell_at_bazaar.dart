import 'dart:io';

class SellAtBazaar {
  String? userType;
  int? userId;
  int? category;
  int? subCategory;
  String? productTitle;
  String? price;
  String? description;
  String? location;
  String? locationLatitude;
  String? locationLongitude;
  List<File>? productImages;

  SellAtBazaar(
      {this.userType,
      this.userId,
      this.category,
      this.subCategory,
      this.productTitle,
      this.price,
      this.description,
      this.location,
      this.locationLatitude,
      this.locationLongitude,
      this.productImages});

  SellAtBazaar.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    userId = json['userId'];
    category = json['category'];
    subCategory = json['subCategory'];
    productTitle = json['productTitle'];
    price = json['price'];
    description = json['description'];
    location = json['location'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
    productImages = json['productImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = userType;
    data['userId'] = "31";
    data['category'] = "1";
    data['subCategory'] = "4";
    data['productTitle'] = productTitle;
    data['price'] = price;
    data['description'] = description;
    data['location'] = location;
    data['locationLatitude'] = locationLatitude;
    data['locationLongitude'] = locationLongitude;
    data['productImages'] = productImages;
    return data;
  }
}