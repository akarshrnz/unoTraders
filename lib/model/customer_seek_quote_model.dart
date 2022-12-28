class CustomerSeekQuoteModel {
  int? id;
  String? type;
  String? mainCategory;
  String? handyman;
  String? name;
  String? email;
  String? username;
  String? webUrl;
  String? countryCode;
  String? mobile;
  String? address;
  String? location;
  String? locLatitude;
  String? locLongitude;
  String? landmark;
  String? landLatitude;
  String? landLongitude;
  String? landmarkData;
  String? serviceLocationRadius;
  String? availableTimeFrom;
  String? availableTimeTo;
  String? isAvailable;
  String? appointment;
  String? status;
  String? featured;
  String? reference;
  String? rating;
  String? profilePic;
  String? qrcode;
  String? completedWorks;
  String? createdAt;
  String? updatedAt;

  CustomerSeekQuoteModel(
      {this.id,
      this.type,
      this.mainCategory,
      this.handyman,
      this.name,
      this.email,
      this.username,
      this.webUrl,
      this.countryCode,
      this.mobile,
      this.address,
      this.location,
      this.locLatitude,
      this.locLongitude,
      this.landmark,
      this.landLatitude,
      this.landLongitude,
      this.landmarkData,
      this.serviceLocationRadius,
      this.availableTimeFrom,
      this.availableTimeTo,
      this.isAvailable,
      this.appointment,
      this.status,
      this.featured,
      this.reference,
      this.rating,
      this.profilePic,
      this.qrcode,
      this.completedWorks,
      this.createdAt,
      this.updatedAt});

  CustomerSeekQuoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    mainCategory = json['main_category'];
    handyman = json['handyman'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    webUrl = json['web_url'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    address = json['address'];
    location = json['location'];
    locLatitude = json['loc_latitude'];
    locLongitude = json['loc_longitude'];
    landmark = json['landmark'];
    landLatitude = json['land_latitude'];
    landLongitude = json['land_longitude'];
    landmarkData = json['landmark_data'];
    serviceLocationRadius = json['service_location_radius'];
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    isAvailable = json['is_available'];
    appointment = json['appointment'];
    status = json['status'];
    featured = json['featured'];
    reference = json['reference'];
    rating = json['rating'];
    profilePic = json['profile_pic'];
    qrcode = json['qrcode'];
    completedWorks = json['completed_works'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['main_category'] = mainCategory;
    data['handyman'] = handyman;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['web_url'] = webUrl;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['address'] = address;
    data['location'] = location;
    data['loc_latitude'] = locLatitude;
    data['loc_longitude'] = locLongitude;
    data['landmark'] = landmark;
    data['land_latitude'] = landLatitude;
    data['land_longitude'] = landLongitude;
    data['landmark_data'] = landmarkData;
    data['service_location_radius'] = serviceLocationRadius;
    data['available_time_from'] = availableTimeFrom;
    data['available_time_to'] = availableTimeTo;
    data['is_available'] = isAvailable;
    data['appointment'] = appointment;
    data['status'] = status;
    data['featured'] = featured;
    data['reference'] = reference;
    data['rating'] = rating;
    data['profile_pic'] = profilePic;
    data['qrcode'] = qrcode;
    data['completed_works'] = completedWorks;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<CustomerSeekQuoteModel> fromSnapshot(List snapshot) {
    return snapshot
        .map((snap) => CustomerSeekQuoteModel.fromJson(snap))
        .toList();
  }
}
