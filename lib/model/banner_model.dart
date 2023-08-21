

class BannerModel {
  int? imageId;
  String? bannerImage;

  BannerModel({this.imageId, this.bannerImage});

  BannerModel.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    bannerImage = json['banner_image'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['banner_image'] = bannerImage;
    return data;
  }
  static List<BannerModel> bannerfromSnapshot(List snapshot){
    return snapshot.map((snap) => BannerModel.fromJson(snap)).toList();

  }
}
// // To parse this JSON data, do
// //
// //     final bannerModel = bannerModelFromJson(jsonString);

// import 'dart:convert';

// BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

// String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

// class BannerModel {
//   BannerModel({
//     required this.status,
//     required this.data,
//     required this.message,
//   });

//   int status;
//   List<Datum> data;
//   String message;

//   factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     message: json["message"],
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "message": message,
//   };
// }

// class Datum {
//   Datum({
//     required this.imageId,
//     required this.bannerImage,
//   });

//   int imageId;
//   String bannerImage;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     imageId: json["imageId"],
//     bannerImage: json["banner_image"],
//   );

//   Map<String, dynamic> toJson() => {
//     "imageId": imageId,
//     "banner_image": bannerImage,
//   };
// }
