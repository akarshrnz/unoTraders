class TraderOfferListingModel {
  String? name;
  String? profilePic;
  int? id;
  String? traderId;
  String? title;
  String? description;
  String? fullPrice;
  String? discountPrice;
  String? validFrom;
  String? validTo;
  String? status;
  String? likes;
  String? reactions;
  String? createdAt;
  String? updatedAt;
  List<String>? traderofferimages;

  TraderOfferListingModel(
      {this.name,
      this.profilePic,
      this.id,
      this.traderId,
      this.title,
      this.description,
      this.fullPrice,
      this.discountPrice,
      this.validFrom,
      this.validTo,
      this.status,
      this.likes,
      this.reactions,
      this.createdAt,
      this.updatedAt,
      this.traderofferimages});
  static List<TraderOfferListingModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => TraderOfferListingModel.fromJson(snap))
        .toList();
  }

  TraderOfferListingModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profile_pic'];
    id = json['id'];
    traderId = json['trader_id'];
    title = json['title'];
    description = json['description'];
    fullPrice = json['full_price'];
    discountPrice = json['discount_price'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    status = json['status'];
    likes = json['likes'];
    reactions = json['reactions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    traderofferimages = json['traderofferimages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_pic'] = profilePic;
    data['id'] = id;
    data['trader_id'] = traderId;
    data['title'] = title;
    data['description'] = description;
    data['full_price'] = fullPrice;
    data['discount_price'] = discountPrice;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['status'] = status;
    data['likes'] = likes;
    data['reactions'] = reactions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['traderofferimages'] = traderofferimages;
    return data;
  }
}
// class TraderOfferListingModel {
//   String? name;
//   String? profilePic;
//   int? id;
//   String? traderId;
//   String? title;
//   String? description;
//   String? fullPrice;
//   String? discountPrice;
//   String? validFrom;
//   String? validTo;
//   String? status;
//   String? likes;
//   String? reactions;
//   String? createdAt;
//   String? updatedAt;
//   List<String>? offerImages;
//   List<Traderofferimages>? traderofferimages;

//   TraderOfferListingModel(
//       {this.name,
//       this.profilePic,
//       this.id,
//       this.traderId,
//       this.title,
//       this.description,
//       this.fullPrice,
//       this.discountPrice,
//       this.validFrom,
//       this.validTo,
//       this.status,
//       this.likes,
//       this.reactions,
//       this.createdAt,
//       this.updatedAt,
//       this.offerImages,
//       this.traderofferimages});

//   static List<TraderOfferListingModel> snapshot(List snapshot) {
//     return snapshot
//         .map((snap) => TraderOfferListingModel.fromJson(snap))
//         .toList();
//   }

//   TraderOfferListingModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     profilePic = json['profile_pic'];
//     id = json['id'];
//     traderId = json['trader_id'];
//     title = json['title'];
//     description = json['description'];
//     fullPrice = json['full_price'];
//     discountPrice = json['discount_price'];
//     validFrom = json['valid_from'];
//     validTo = json['valid_to'];
//     status = json['status'];
//     likes = json['likes'];
//     reactions = json['reactions'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     offerImages = json['offer_images'].cast<String>();
//     if (json['traderofferimages'] != null) {
//       traderofferimages = <Traderofferimages>[];
//       json['traderofferimages'].forEach((v) {
//         traderofferimages!.add(new Traderofferimages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['profile_pic'] = profilePic;
//     data['id'] = id;
//     data['trader_id'] = traderId;
//     data['title'] = title;
//     data['description'] = description;
//     data['full_price'] = fullPrice;
//     data['discount_price'] = discountPrice;
//     data['valid_from'] = validFrom;
//     data['valid_to'] = validTo;
//     data['status'] = status;
//     data['likes'] = likes;
//     data['reactions'] = reactions;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['offer_images'] = offerImages;
//     if (traderofferimages != null) {
//       data['traderofferimages'] =
//           traderofferimages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Traderofferimages {
//   int? id;
//   String? traderOfferId;
//   String? offerImage;
//   String? createdAt;
//   String? updatedAt;

//   Traderofferimages(
//       {this.id,
//       this.traderOfferId,
//       this.offerImage,
//       this.createdAt,
//       this.updatedAt});

//   Traderofferimages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderOfferId = json['trader_offer_id'];
//     offerImage = json['offer_image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_offer_id'] = traderOfferId;
//     data['offer_image'] = offerImage;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
