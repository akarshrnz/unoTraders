class JobSearchModel {
  String? keyword;
  int? category;
  int? subcategory;
  double? latitude;
  double? longitude;

  int? distance;

  JobSearchModel(
      {this.keyword,
      this.category,
      this.subcategory,
      this.latitude,
      this.longitude,
      this.distance});

  JobSearchModel.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    category = json['category'];
    subcategory = json['subcategory'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['latitude'] = latitude;

    data['longitude'] = longitude;
    data['distance'] = distance;
    return data;
  }
}
