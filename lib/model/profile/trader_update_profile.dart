import 'dart:io';

class TraderUpdateProfile {
  String? mainCategory;
  String? type;
  String? name;
  String? countryCode;
  String? serviceLocationRadius;
  String? availableTimeFrom;
  String? availableTimeTo;
  int? handyman;
  String? webUrl;
  String? address;
  String? mobile;
  String? email;
  int? isAvailable;
  int? appointment;
  int? reference;
  String? userType;
  int? traderId;
  String? location;
  String? locLatitude;
  String? locLongitude;
  String? landmark;
  String? landLatitude;
  String? landLongitude;
  String? landmarkDesc;
  File? profilePic;

  TraderUpdateProfile(
      {this.mainCategory,
      this.profilePic,
      this.name,
      this.type,
      this.countryCode,
      this.availableTimeFrom,
      this.availableTimeTo,
      this.handyman,
      this.serviceLocationRadius,
      this.webUrl,
      this.address,
      this.mobile,
      this.email,
      this.isAvailable,
      this.appointment,
      this.reference,
      this.userType,
      this.traderId,
      this.location,
      this.locLatitude,
      this.locLongitude,
      this.landmark,
      this.landLatitude,
      this.landLongitude,
      this.landmarkDesc});

  TraderUpdateProfile.fromJson(Map<String, dynamic> json) {
    mainCategory = json['main_category'];
    type = json['type'];
    name = json['name'];
    countryCode = json['country_code'];
    serviceLocationRadius = json['service_location_radius'];
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    handyman = json['handyman'];
    webUrl = json['web_url'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
    isAvailable = json[' is_available'];
    appointment = json['appointment'];
    reference = json['reference'];
    userType = json['user_type'];
    traderId = json['trader_id'];
    location = json['location'];
    locLatitude = json['loc_latitude'];
    locLongitude = json['loc_longitude'];
    landmark = json['landmark'];
    landLatitude = json['land_latitude'];
    landLongitude = json['land_longitude'];
    landmarkDesc = json['landmark_desc'];
    profilePic = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_image'] = profilePic;
    data['main_category'] = mainCategory;
    data['type'] = type;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['service_location_radius'] = serviceLocationRadius;
    data['available_time_from'] = availableTimeFrom;
    data['available_time_to'] = availableTimeTo;
    data['handyman'] = handyman;
    data['web_url'] = webUrl;
    data['address'] = address;
    data['mobile'] = mobile;
    data['email'] = email;
    data[' is_available'] = isAvailable;
    data['appointment'] = appointment;
    data['reference'] = reference;
    data['user_type'] = userType;
    data['trader_id'] = traderId;
    data['location'] = location;
    data['loc_latitude'] = locLatitude;
    data['loc_longitude'] = locLongitude;
    data['landmark'] = landmark;
    data['land_latitude'] = landLatitude;
    data['land_longitude'] = landLongitude;
    data['landmark_desc'] = landmarkDesc;
    return data;
  }
}
