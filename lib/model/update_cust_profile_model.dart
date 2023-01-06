class UpdateCusProfileModel {
  String? name;
  String? location;
  String? locationLatitude;
  String? locationLongitude;
  String? profileImage;
  String? address;

  UpdateCusProfileModel(
      {this.name,
      this.location,
      this.locationLatitude,
      this.locationLongitude,
      this.profileImage,
      this.address});

  UpdateCusProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    locationLatitude = json['locationLatitude'];
    locationLongitude = json['locationLongitude'];
    profileImage = json['profileImage'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['locationLatitude'] = locationLatitude;
    data['locationLongitude'] = locationLongitude;
    data['profileImage'] = profileImage;
    data['address'] = address;
    return data;
  }
}
