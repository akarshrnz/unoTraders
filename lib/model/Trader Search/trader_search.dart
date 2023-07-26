class TraderSearch {
  double? lat;
  double? long;
  String? trade;
  int? distance;
  int? userId;
  String? userType;
  int? offset;
  int? rating;
  int? sortBy;
  int? category;

  TraderSearch(
      {this.lat,
      this.long,
      this.trade,
      this.category,
      this.sortBy,
      this.rating,
      this.distance,
      this.userId,
      this.userType,
      this.offset});

  TraderSearch.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    trade = json['trade'];
    distance = json['distance'];
    userId = json['user_id'];
    userType = json['user_type'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['trade'] = trade;
    data['distance'] = distance;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['offset'] = offset;
    data['sort_by'] = sortBy;
    data['rating'] = rating;
    data['category'] = category;
    return data;
  }
}
