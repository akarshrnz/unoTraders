class CustomerProfileModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? countryCode;
  String? mobile;
  String? address;
  String? location;
  String? locLatitude;
  String? locLongitude;
  int? status;
  String? profilePic;
  String? createdAt;
  String? updatedAt;
  int? following;
  int? favorites;

  CustomerProfileModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.countryCode,
      this.mobile,
      this.address,
      this.location,
      this.locLatitude,
      this.locLongitude,
      this.status,
      this.profilePic,
      this.createdAt,
      this.updatedAt,
      this.following,
      this.favorites});

  CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    address = json['address'];
    location = json['location'];
    locLatitude = json['loc_latitude'];
    locLongitude = json['loc_longitude'];
    status = json['status'];
    profilePic = json['profile_pic'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    following = json['following'];
    favorites = json['favorites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['address'] = address;
    data['location'] = location;
    data['loc_latitude'] = locLatitude;
    data['loc_longitude'] = locLongitude;
    data['status'] = status;
    data['profile_pic'] = profilePic;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['following'] = following;
    data['favorites'] = favorites;
    return data;
  }
}

// class CustomerProfileModel {
//   int? id;
//   String? name;
//   String? email;
//   String? username;
//   String? countryCode;
//   String? mobile;
//   String? address;
//   String? location;
//   String? locLatitude;
//   String? locLongitude;
//   int? status;
//   String? profilePic;
//   String? createdAt;
//   String? updatedAt;
//   int? following;
//   int? favorites;

//   CustomerProfileModel(
//       {this.id,
//       this.name,
//       this.email,
//       this.username,
//       this.countryCode,
//       this.mobile,
//       this.address,
//       this.location,
//       this.locLatitude,
//       this.locLongitude,
//       this.status,
//       this.profilePic,
//       this.createdAt,
//       this.updatedAt,
//       this.following,
//       this.favorites});

//   CustomerProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     username = json['username'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     address = json['address'];
//     location = json['location'];
//     locLatitude = json['loc_latitude'];
//     locLongitude = json['loc_longitude'];
//     status = json['status'];
//     profilePic = json['profile_pic'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     following = json['following'];
//     favorites = json['favorites'];
//   }
// }
