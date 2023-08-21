import 'dart:io';

class UpdateProfileModel {
  String? name;
  String? address;
  String? location;
  String? locationLatitude;
  String? locationLongitude;
  File? profileImage;

  UpdateProfileModel(
      {this.name,
      this.address,
      this.location,
      this.locationLatitude,
      this.locationLongitude,
      this.profileImage});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name '];
    address = json['address'];
    location = json['location'];
    locationLatitude = json['locationLatitute'];
    locationLongitude = json['locationLongitude'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name '] = name;
    data['address'] = address;
    data['location'] = location;
    data['locationLatitute'] = locationLatitude;
    data['locationLongitude'] = locationLongitude;
    data['profileImage'] = profileImage;
    return data;
  }
}
