class AddReviewModel {
  int? traderId;
  int? customerId;
  String? workCompleted;
  int? serviceId;
  String? serviceDate;
  String? review;
  String? reliability;
  String? cleanliness;
  String? response;
  String? accuracy;
  String? quotation;
  String? overallExperience;
  String? recommend;

  AddReviewModel(
      {this.traderId,
      this.customerId,
      this.workCompleted,
      this.serviceId,
      this.serviceDate,
      this.review,
      this.reliability,
      this.cleanliness,
      this.response,
      this.accuracy,
      this.quotation,
      this.overallExperience,
      this.recommend});

  AddReviewModel.fromJson(Map<String, dynamic> json) {
    traderId = json['traderId'];
    customerId = json['customerId'];
    workCompleted = json['workCompleted'];
    serviceId = json['serviceId'];
    serviceDate = json['serviceDate'];
    review = json['review'];
    reliability = json['reliability'];
    cleanliness = json['cleanliness'];
    response = json['response'];
    accuracy = json['accuracy'];
    quotation = json['quotation'];
    overallExperience = json['overallExperience'];
    recommend = json['recommend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traderId'] = traderId;
    data['customerId'] = customerId;
    data['workCompleted'] = workCompleted;
    data['serviceId'] = serviceId;
    data['serviceDate'] = serviceDate;
    data['review'] = review;
    data['reliability'] = reliability;
    data['cleanliness'] = cleanliness;
    data['response'] = response;
    data['accuracy'] = accuracy;
    data['quotation'] = quotation;
    data['overallExperience'] = overallExperience;
    data['recommend'] = recommend;
    return data;
  }
}
