class ProviderProfileModel {
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
  List<Providercategories>? providercategories;
  List<Providerreviews>? providerreviews;

  ProviderProfileModel(
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
      this.updatedAt,
      this.providercategories,
      this.providerreviews});

  static List<ProviderProfileModel> snapshot(List snapshot) {
    return snapshot.map((snap) => ProviderProfileModel.fromJson(snap)).toList();
  }

  ProviderProfileModel.fromJson(Map<String, dynamic> json) {
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
    if (json['providercategories'] != null) {
      providercategories = <Providercategories>[];
      json['providercategories'].forEach((v) {
        providercategories!.add(new Providercategories.fromJson(v));
      });
    }
    if (json['providerreviews'] != null) {
      providerreviews = <Providerreviews>[];
      json['providerreviews'].forEach((v) {
        providerreviews!.add(new Providerreviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['main_category'] = this.mainCategory;
    data['handyman'] = this.handyman;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['web_url'] = this.webUrl;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['location'] = this.location;
    data['loc_latitude'] = this.locLatitude;
    data['loc_longitude'] = this.locLongitude;
    data['landmark'] = this.landmark;
    data['land_latitude'] = this.landLatitude;
    data['land_longitude'] = this.landLongitude;
    data['landmark_data'] = this.landmarkData;
    data['service_location_radius'] = this.serviceLocationRadius;
    data['available_time_from'] = this.availableTimeFrom;
    data['available_time_to'] = this.availableTimeTo;
    data['is_available'] = this.isAvailable;
    data['appointment'] = this.appointment;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['reference'] = this.reference;
    data['rating'] = this.rating;
    data['profile_pic'] = this.profilePic;
    data['qrcode'] = this.qrcode;
    data['completed_works'] = this.completedWorks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.providercategories != null) {
      data['providercategories'] =
          this.providercategories!.map((v) => v.toJson()).toList();
    }
    if (this.providerreviews != null) {
      data['providerreviews'] =
          this.providerreviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providercategories {
  int? id;
  String? providerId;
  String? categoryId;
  String? subCategoryId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Providercategories(
      {this.id,
      this.providerId,
      this.categoryId,
      this.subCategoryId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Providercategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Providerreviews {
  int? id;
  String? traderId;
  String? userId;
  String? workCompleted;
  String? serviceId;
  String? serviceDate;
  String? review;
  String? reliability;
  String? tidiness;
  String? response;
  String? accuracy;
  String? pricing;
  String? overallExp;
  String? recommend;
  String? status;
  String? createdAt;
  String? updatedAt;

  Providerreviews(
      {this.id,
      this.traderId,
      this.userId,
      this.workCompleted,
      this.serviceId,
      this.serviceDate,
      this.review,
      this.reliability,
      this.tidiness,
      this.response,
      this.accuracy,
      this.pricing,
      this.overallExp,
      this.recommend,
      this.status,
      this.createdAt,
      this.updatedAt});

  Providerreviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderId = json['trader_id'];
    userId = json['user_id'];
    workCompleted = json['work_completed'];
    serviceId = json['service_id'];
    serviceDate = json['service_date'];
    review = json['review'];
    reliability = json['reliability'];
    tidiness = json['tidiness'];
    response = json['response'];
    accuracy = json['accuracy'];
    pricing = json['pricing'];
    overallExp = json['overall_exp'];
    recommend = json['recommend'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_id'] = traderId;
    data['user_id'] = userId;
    data['work_completed'] = workCompleted;
    data['service_id'] = serviceId;
    data['service_date'] = serviceDate;
    data['review'] = review;
    data['reliability'] = reliability;
    data['tidiness'] = tidiness;
    data['response'] = response;
    data['accuracy'] = accuracy;
    data['pricing'] = pricing;
    data['overall_exp'] = overallExp;
    data['recommend'] = recommend;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
