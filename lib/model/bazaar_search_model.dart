class BazaarSearchModel {
  String? product;
  int? category;
  int? subcategory;
  double? latitude;
  double? longitude;
  int? sortBy;
  int? distance;

  BazaarSearchModel(
      {this.product,
      this.category,
      this.subcategory,
      this.latitude,
      this.longitude,
      this.sortBy,
      this.distance});

  BazaarSearchModel.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    category = json['category'];
    subcategory = json['subcategory'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    sortBy = json['sort_by'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['latitude'] = latitude;
    data['sort_by'] = sortBy ?? 1;
    data['longitude'] = longitude;
    data['distance'] = distance;
    return data;
  }
}
