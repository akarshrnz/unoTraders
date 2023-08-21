import 'dart:io';

class PostOfferModel {
  int? traderId;
  String? offerTitle;
  String? offerContent;
  String? fullPrice;
  String? offerPrice;
  String? validFrom;
  String? validTo;
  List<File>? offerImages;

  PostOfferModel(
      {this.traderId,
      this.offerTitle,
      this.offerContent,
      this.fullPrice,
      this.offerPrice,
      this.validFrom,
      this.validTo,
      this.offerImages});

  PostOfferModel.fromJson(Map<String, dynamic> json) {
    traderId = json['traderId'];
    offerTitle = json['offerTitle'];
    offerContent = json['offerContent'];
    fullPrice = json['fullPrice'];
    offerPrice = json['offerPrice'];
    validFrom = json['validFrom'];
    validTo = json['validTo'];
    offerImages = json['offerImages[]'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traderId'] = traderId;
    data['offerTitle'] = offerTitle;
    data['offerContent'] = offerContent;
    data['fullPrice'] = fullPrice;
    data['offerPrice'] = offerPrice;
    data['validFrom'] = validFrom;
    data['validTo'] = validTo;
    data['offerImages[]'] = offerImages;
    return data;
  }
}
