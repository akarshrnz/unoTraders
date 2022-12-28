class CustomerProfileModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? countryCode;
  String? mobile;
  String? address;
  String? location;
  int? locLatitude;
  int? locLongitude;
  int? status;
  String? profilePic;
  String? createdAt;
  String? updatedAt;

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
      this.updatedAt});

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
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['username'] = this.username;
  //   data['country_code'] = this.countryCode;
  //   data['mobile'] = this.mobile;
  //   data['address'] = this.address;
  //   data['location'] = this.location;
  //   data['loc_latitude'] = this.locLatitude;
  //   data['loc_longitude'] = this.locLongitude;
  //   data['status'] = this.status;
  //   data['profile_pic'] = this.profilePic;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
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
//   String? status;
//   String? profilePic;
//   String? createdAt;
//   String? updatedAt;


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
//       this.updatedAt});

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
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['username'] = username;
//     data['country_code'] = countryCode;
//     data['mobile'] = mobile;
//     data['address'] = address;
//     data['location'] = location;
//     data['loc_latitude'] = locLatitude;
//     data['loc_longitude'] = locLongitude;
//     data['status'] = status;
//     data['profile_pic'] = profilePic;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }