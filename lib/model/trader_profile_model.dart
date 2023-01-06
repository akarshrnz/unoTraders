class TraderProfileModel {
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
  int? followers;
  int? favourites;
  List<String>? completedimages;
  List<Traderposts>? traderposts;
  List<Traderoffers>? traderoffers;
  List<Traderreviews>? traderreviews;
  List<Providerreviews>? providerreviews;
  List<Providerfollows>? providerfollows;
  List<Providerfavourites>? providerfavourites;
  List<Providerworks>? providerworks;
  List<Providerposts>? providerposts;
  List<Provideroffers>? provideroffers;

  TraderProfileModel(
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
      this.followers,
      this.favourites,
      this.completedimages,
      this.traderposts,
      this.traderoffers,
      this.traderreviews,
      this.providerreviews,
      this.providerfollows,
      this.providerfavourites,
      this.providerworks,
      this.providerposts,
      this.provideroffers});

  TraderProfileModel.fromJson(Map<String, dynamic> json) {
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
    followers = json['followers'];
    favourites = json['favourites'];
    completedimages = json['completedimages'].cast<String>();
    if (json['traderposts'] != null) {
      traderposts = <Traderposts>[];
      json['traderposts'].forEach((v) {
        traderposts!.add(Traderposts.fromJson(v));
      });
    }
    if (json['traderoffers'] != null) {
      traderoffers = <Traderoffers>[];
      json['traderoffers'].forEach((v) {
        traderoffers!.add(Traderoffers.fromJson(v));
      });
    }
    if (json['traderreviews'] != null) {
      traderreviews = <Traderreviews>[];
      json['traderreviews'].forEach((v) {
        traderreviews!.add(Traderreviews.fromJson(v));
      });
    }
    if (json['providerreviews'] != null) {
      providerreviews = <Providerreviews>[];
      json['providerreviews'].forEach((v) {
        providerreviews!.add(Providerreviews.fromJson(v));
      });
    }
    if (json['providerfollows'] != null) {
      providerfollows = <Providerfollows>[];
      json['providerfollows'].forEach((v) {
        providerfollows!.add(Providerfollows.fromJson(v));
      });
    }
    if (json['providerfavourites'] != null) {
      providerfavourites = <Providerfavourites>[];
      json['providerfavourites'].forEach((v) {
        providerfavourites!.add(Providerfavourites.fromJson(v));
      });
    }
    if (json['providerworks'] != null) {
      providerworks = <Providerworks>[];
      json['providerworks'].forEach((v) {
        providerworks!.add(Providerworks.fromJson(v));
      });
    }
    if (json['providerposts'] != null) {
      providerposts = <Providerposts>[];
      json['providerposts'].forEach((v) {
        providerposts!.add(Providerposts.fromJson(v));
      });
    }
    if (json['provideroffers'] != null) {
      provideroffers = <Provideroffers>[];
      json['provideroffers'].forEach((v) {
        provideroffers!.add(Provideroffers.fromJson(v));
      });
    }
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
    data['followers'] = followers;
    data['favourites'] = favourites;
    data['completedimages'] = completedimages;
    if (traderposts != null) {
      data['traderposts'] = traderposts!.map((v) => v.toJson()).toList();
    }
    if (traderoffers != null) {
      data['traderoffers'] = traderoffers!.map((v) => v.toJson()).toList();
    }
    if (traderreviews != null) {
      data['traderreviews'] = traderreviews!.map((v) => v.toJson()).toList();
    }
    if (providerreviews != null) {
      data['providerreviews'] =
          providerreviews!.map((v) => v.toJson()).toList();
    }
    if (providerfollows != null) {
      data['providerfollows'] =
          providerfollows!.map((v) => v.toJson()).toList();
    }
    if (providerfavourites != null) {
      data['providerfavourites'] =
          providerfavourites!.map((v) => v.toJson()).toList();
    }
    if (providerworks != null) {
      data['providerworks'] = providerworks!.map((v) => v.toJson()).toList();
    }
    if (providerposts != null) {
      data['providerposts'] = providerposts!.map((v) => v.toJson()).toList();
    }
    if (provideroffers != null) {
      data['provideroffers'] = provideroffers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Traderposts {
  int? postId;
  String? postTitle;
  String? postContent;
  String? createdAt;
  List<String>? postImages;

  Traderposts(
      {this.postId,
      this.postTitle,
      this.postContent,
      this.createdAt,
      this.postImages});

  Traderposts.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postTitle = json['post_title'];
    postContent = json['post_content'];
    createdAt = json['created_at'];
    postImages = json['post_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['post_title'] = postTitle;
    data['post_content'] = postContent;
    data['created_at'] = createdAt;
    data['post_images'] = postImages;
    return data;
  }
}

class Traderoffers {
  int? offerId;
  String? offerTitle;
  String? offerDescription;
  String? fullPrice;
  String? discountPrice;
  String? validFrom;
  String? validTo;
  String? createdAt;
  List<String>? offerImages;

  Traderoffers(
      {this.offerId,
      this.offerTitle,
      this.offerDescription,
      this.fullPrice,
      this.discountPrice,
      this.validFrom,
      this.validTo,
      this.createdAt,
      this.offerImages});

  Traderoffers.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offerTitle = json['offer_title'];
    offerDescription = json['offer_description'];
    fullPrice = json['full_price'];
    discountPrice = json['discount_price'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    createdAt = json['created_at'];
    offerImages = json['offer_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['offer_title'] = offerTitle;
    data['offer_description'] = offerDescription;
    data['full_price'] = fullPrice;
    data['discount_price'] = discountPrice;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['created_at'] = createdAt;
    data['offer_images'] = offerImages;
    return data;
  }
}

class Traderreviews {
  int? reviewId;
  String? customerId;
  String? customerName;
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
  String? createdAt;

  Traderreviews(
      {this.reviewId,
      this.customerId,
      this.customerName,
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
      this.createdAt});

  Traderreviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
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
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
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
    data['created_at'] = createdAt;
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
  Getuser? getuser;

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
      this.updatedAt,
      this.getuser});

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
    getuser =
        json['getuser'] != null ? Getuser.fromJson(json['getuser']) : null;
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
    if (getuser != null) {
      data['getuser'] = getuser!.toJson();
    }
    return data;
  }
}

class Getuser {
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
  String? status;
  String? profilePic;
  String? createdAt;
  String? updatedAt;

  Getuser(
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

  Getuser.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Providerfollows {
  int? id;
  String? userType;
  int? userId;
  int? traderId;
  int? follow;
  String? createdAt;
  String? updatedAt;

  Providerfollows(
      {this.id,
      this.userType,
      this.userId,
      this.traderId,
      this.follow,
      this.createdAt,
      this.updatedAt});

  Providerfollows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    follow = json['follow'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['follow'] = follow;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Providerfavourites {
  int? id;
  String? userType;
  int? userId;
  int? traderId;
  int? favourite;
  String? createdAt;
  String? updatedAt;

  Providerfavourites(
      {this.id,
      this.userType,
      this.userId,
      this.traderId,
      this.favourite,
      this.createdAt,
      this.updatedAt});

  Providerfavourites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    favourite = json['favourite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['favourite'] = favourite;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Providerworks {
  int? id;
  String? providerId;
  String? serviceId;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Providerworks(
      {this.id,
      this.providerId,
      this.serviceId,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Providerworks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    serviceId = json['service_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['service_id'] = serviceId;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Providerposts {
  int? id;
  int? traderId;
  String? title;
  String? postContent;
  int? status;
  String? emoji;
  String? likes;
  String? reactions;
  String? createdAt;
  String? updatedAt;
  List<Traderpostimages>? traderpostimages;

  Providerposts(
      {this.id,
      this.traderId,
      this.title,
      this.postContent,
      this.status,
      this.emoji,
      this.likes,
      this.reactions,
      this.createdAt,
      this.updatedAt,
      this.traderpostimages});

  Providerposts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderId = json['trader_id'];
    title = json['title'];
    postContent = json['post_content'];
    status = json['status'];
    emoji = json['emoji'];
    likes = json['likes'];
    reactions = json['reactions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['traderpostimages'] != null) {
      traderpostimages = <Traderpostimages>[];
      json['traderpostimages'].forEach((v) {
        traderpostimages!.add(Traderpostimages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_id'] = traderId;
    data['title'] = title;
    data['post_content'] = postContent;
    data['status'] = status;
    data['emoji'] = emoji;
    data['likes'] = likes;
    data['reactions'] = reactions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (traderpostimages != null) {
      data['traderpostimages'] =
          traderpostimages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Traderpostimages {
  int? id;
  int? traderPostId;
  String? postImage;
  String? createdAt;
  String? updatedAt;

  Traderpostimages(
      {this.id,
      this.traderPostId,
      this.postImage,
      this.createdAt,
      this.updatedAt});

  Traderpostimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderPostId = json['trader_post_id'];
    postImage = json['post_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_post_id'] = traderPostId;
    data['post_image'] = postImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Provideroffers {
  int? id;
  int? traderId;
  String? title;
  String? description;
  String? fullPrice;
  String? discountPrice;
  String? validFrom;
  String? validTo;
  int? status;
  String? likes;
  String? reactions;
  String? createdAt;
  String? updatedAt;
  List<Traderofferimages>? traderofferimages;

  Provideroffers(
      {this.id,
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

  Provideroffers.fromJson(Map<String, dynamic> json) {
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
    if (json['traderofferimages'] != null) {
      traderofferimages = <Traderofferimages>[];
      json['traderofferimages'].forEach((v) {
        traderofferimages!.add(Traderofferimages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (traderofferimages != null) {
      data['traderofferimages'] =
          traderofferimages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Traderofferimages {
  int? id;
  int? traderOfferId;
  String? offerImage;
  String? createdAt;
  String? updatedAt;

  Traderofferimages(
      {this.id,
      this.traderOfferId,
      this.offerImage,
      this.createdAt,
      this.updatedAt});

  Traderofferimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    traderOfferId = json['trader_offer_id'];
    offerImage = json['offer_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trader_offer_id'] = traderOfferId;
    data['offer_image'] = offerImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


// class TraderProfileModel {
//   int? id;
//   String? type;
//   String? mainCategory;
//   String? handyman;
//   String? name;
//   String? email;
//   String? username;
//   String? webUrl;
//   String? countryCode;
//   String? mobile;
//   String? address;
//   String? location;
//   String? locLatitude;
//   String? locLongitude;
//   String? landmark;
//   String? landLatitude;
//   String? landLongitude;
//   String? landmarkData;
//   String? serviceLocationRadius;
//   String? availableTimeFrom;
//   String? availableTimeTo;
//   String? isAvailable;
//   String? appointment;
//   String? status;
//   String? featured;
//   String? reference;
//   String? rating;
//   String? profilePic;
//   String? qrcode;
//   String? completedWorks;
//   String? createdAt;
//   String? updatedAt;
//   int? followers;
//   int? favourites;
//   List<String>? completedimages;
//   List<Traderposts>? traderposts;
//   List<Traderoffers>? traderoffers;
//   List<Traderreviews>? traderreviews;
//   List<Providerreviews>? providerreviews;
//   List<Providerfollows>? providerfollows;
//   List<Providerfavourites>? providerfavourites;
//   List<Providerworks>? providerworks;
//   List<Providerposts>? providerposts;
//   List<Provideroffers>? provideroffers;

//   TraderProfileModel(
//       {this.id,
//       this.type,
//       this.mainCategory,
//       this.handyman,
//       this.name,
//       this.email,
//       this.username,
//       this.webUrl,
//       this.countryCode,
//       this.mobile,
//       this.address,
//       this.location,
//       this.locLatitude,
//       this.locLongitude,
//       this.landmark,
//       this.landLatitude,
//       this.landLongitude,
//       this.landmarkData,
//       this.serviceLocationRadius,
//       this.availableTimeFrom,
//       this.availableTimeTo,
//       this.isAvailable,
//       this.appointment,
//       this.status,
//       this.featured,
//       this.reference,
//       this.rating,
//       this.profilePic,
//       this.qrcode,
//       this.completedWorks,
//       this.createdAt,
//       this.updatedAt,
//       this.followers,
//       this.favourites,
//       this.completedimages,
//       this.traderposts,
//       this.traderoffers,
//       this.traderreviews,
//       this.providerreviews,
//       this.providerfollows,
//       this.providerfavourites,
//       this.providerworks,
//       this.providerposts,
//       this.provideroffers});

//   TraderProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     mainCategory = json['main_category'];
//     handyman = json['handyman'];
//     name = json['name'];
//     email = json['email'];
//     username = json['username'];
//     webUrl = json['web_url'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     address = json['address'];
//     location = json['location'];
//     locLatitude = json['loc_latitude'];
//     locLongitude = json['loc_longitude'];
//     landmark = json['landmark'];
//     landLatitude = json['land_latitude'];
//     landLongitude = json['land_longitude'];
//     landmarkData = json['landmark_data'];
//     serviceLocationRadius = json['service_location_radius'];
//     availableTimeFrom = json['available_time_from'];
//     availableTimeTo = json['available_time_to'];
//     isAvailable = json['is_available'];
//     appointment = json['appointment'];
//     status = json['status'];
//     featured = json['featured'];
//     reference = json['reference'];
//     rating = json['rating'];
//     profilePic = json['profile_pic'];
//     qrcode = json['qrcode'];
//     completedWorks = json['completed_works'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     followers = json['followers'];
//     favourites = json['favourites'];
//     completedimages = json['completedimages'].cast<String>();
//     if (json['traderposts'] != null) {
//       traderposts = <Traderposts>[];
//       json['traderposts'].forEach((v) {
//         traderposts!.add(Traderposts.fromJson(v));
//       });
//     }
//     if (json['traderoffers'] != null) {
//       traderoffers = <Traderoffers>[];
//       json['traderoffers'].forEach((v) {
//         traderoffers!.add(Traderoffers.fromJson(v));
//       });
//     }
//     if (json['traderreviews'] != null) {
//       traderreviews = <Traderreviews>[];
//       json['traderreviews'].forEach((v) {
//         traderreviews!.add(Traderreviews.fromJson(v));
//       });
//     }
//     if (json['providerreviews'] != null) {
//       providerreviews = <Providerreviews>[];
//       json['providerreviews'].forEach((v) {
//         providerreviews!.add(Providerreviews.fromJson(v));
//       });
//     }
//     if (json['providerfollows'] != null) {
//       providerfollows = <Providerfollows>[];
//       json['providerfollows'].forEach((v) {
//         providerfollows!.add(Providerfollows.fromJson(v));
//       });
//     }
//     if (json['providerfavourites'] != null) {
//       providerfavourites = <Providerfavourites>[];
//       json['providerfavourites'].forEach((v) {
//         providerfavourites!.add(Providerfavourites.fromJson(v));
//       });
//     }
//     if (json['providerworks'] != null) {
//       providerworks = <Providerworks>[];
//       json['providerworks'].forEach((v) {
//         providerworks!.add(Providerworks.fromJson(v));
//       });
//     }
//     if (json['providerposts'] != null) {
//       providerposts = <Providerposts>[];
//       json['providerposts'].forEach((v) {
//         providerposts!.add(Providerposts.fromJson(v));
//       });
//     }
//     if (json['provideroffers'] != null) {
//       provideroffers = <Provideroffers>[];
//       json['provideroffers'].forEach((v) {
//         provideroffers!.add(Provideroffers.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     data['main_category'] = mainCategory;
//     data['handyman'] = handyman;
//     data['name'] = name;
//     data['email'] = email;
//     data['username'] = username;
//     data['web_url'] = webUrl;
//     data['country_code'] = countryCode;
//     data['mobile'] = mobile;
//     data['address'] = address;
//     data['location'] = location;
//     data['loc_latitude'] = locLatitude;
//     data['loc_longitude'] = locLongitude;
//     data['landmark'] = landmark;
//     data['land_latitude'] = landLatitude;
//     data['land_longitude'] = landLongitude;
//     data['landmark_data'] = landmarkData;
//     data['service_location_radius'] = serviceLocationRadius;
//     data['available_time_from'] = availableTimeFrom;
//     data['available_time_to'] = availableTimeTo;
//     data['is_available'] = isAvailable;
//     data['appointment'] = appointment;
//     data['status'] = status;
//     data['featured'] = featured;
//     data['reference'] = reference;
//     data['rating'] = rating;
//     data['profile_pic'] = profilePic;
//     data['qrcode'] = qrcode;
//     data['completed_works'] = completedWorks;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['followers'] = followers;
//     data['favourites'] = favourites;
//     data['completedimages'] = completedimages;
//     if (traderposts != null) {
//       data['traderposts'] = traderposts!.map((v) => v.toJson()).toList();
//     }
//     if (traderoffers != null) {
//       data['traderoffers'] = traderoffers!.map((v) => v.toJson()).toList();
//     }
//     if (traderreviews != null) {
//       data['traderreviews'] = traderreviews!.map((v) => v.toJson()).toList();
//     }
//     if (providerreviews != null) {
//       data['providerreviews'] =
//           providerreviews!.map((v) => v.toJson()).toList();
//     }
//     if (providerfollows != null) {
//       data['providerfollows'] =
//           providerfollows!.map((v) => v.toJson()).toList();
//     }
//     if (providerfavourites != null) {
//       data['providerfavourites'] =
//           providerfavourites!.map((v) => v.toJson()).toList();
//     }
//     if (providerworks != null) {
//       data['providerworks'] = providerworks!.map((v) => v.toJson()).toList();
//     }
//     if (providerposts != null) {
//       data['providerposts'] = providerposts!.map((v) => v.toJson()).toList();
//     }
//     if (provideroffers != null) {
//       data['provideroffers'] = provideroffers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Traderposts {
//   int? postId;
//   String? postTitle;
//   String? postContent;
//   String? createdAt;
//   List<String>? postImages;

//   Traderposts(
//       {this.postId,
//       this.postTitle,
//       this.postContent,
//       this.createdAt,
//       this.postImages});

//   Traderposts.fromJson(Map<String, dynamic> json) {
//     postId = json['post_id'];
//     postTitle = json['post_title'];
//     postContent = json['post_content'];
//     createdAt = json['created_at'];
//     postImages =null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['post_id'] = postId;
//     data['post_title'] = postTitle;
//     data['post_content'] = postContent;
//     data['created_at'] = createdAt;
//     data['post_images'] = postImages;
//     return data;
//   }
// }

// class Traderoffers {
//   int? offerId;
//   String? offerTitle;
//   String? offerDescription;
//   String? fullPrice;
//   String? discountPrice;
//   String? validFrom;
//   String? validTo;
//   String? createdAt;
//   List<String>? offerImages;

//   Traderoffers(
//       {this.offerId,
//       this.offerTitle,
//       this.offerDescription,
//       this.fullPrice,
//       this.discountPrice,
//       this.validFrom,
//       this.validTo,
//       this.createdAt,
//       this.offerImages});

//   Traderoffers.fromJson(Map<String, dynamic> json) {
//     offerId = json['offer_id'];
//     offerTitle = json['offer_title'];
//     offerDescription = json['offer_description'];
//     fullPrice = json['full_price'];
//     discountPrice = json['discount_price'];
//     validFrom = json['valid_from'];
//     validTo = json['valid_to'];
//     createdAt = json['created_at'];
//     offerImages = json['offer_images'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['offer_id'] = offerId;
//     data['offer_title'] = offerTitle;
//     data['offer_description'] = offerDescription;
//     data['full_price'] = fullPrice;
//     data['discount_price'] = discountPrice;
//     data['valid_from'] = validFrom;
//     data['valid_to'] = validTo;
//     data['created_at'] = createdAt;
//     data['offer_images'] = offerImages;
//     return data;
//   }
// }

// class Traderreviews {
//   int? reviewId;
//   String? customerId;
//   String? customerName;
//   String? workCompleted;
//   String? serviceId;
//   String? serviceDate;
//   String? review;
//   String? reliability;
//   String? tidiness;
//   String? response;
//   String? accuracy;
//   String? pricing;
//   String? overallExp;
//   String? recommend;
//   String? createdAt;

//   Traderreviews(
//       {this.reviewId,
//       this.customerId,
//       this.customerName,
//       this.workCompleted,
//       this.serviceId,
//       this.serviceDate,
//       this.review,
//       this.reliability,
//       this.tidiness,
//       this.response,
//       this.accuracy,
//       this.pricing,
//       this.overallExp,
//       this.recommend,
//       this.createdAt});

//   Traderreviews.fromJson(Map<String, dynamic> json) {
//     reviewId = json['review_id'];
//     customerId = json['customer_id'];
//     customerName = json['customer_name'];
//     workCompleted = json['work_completed'];
//     serviceId = json['service_id'];
//     serviceDate = json['service_date'];
//     review = json['review'];
//     reliability = json['reliability'];
//     tidiness = json['tidiness'];
//     response = json['response'];
//     accuracy = json['accuracy'];
//     pricing = json['pricing'];
//     overallExp = json['overall_exp'];
//     recommend = json['recommend'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['review_id'] = reviewId;
//     data['customer_id'] = customerId;
//     data['customer_name'] = customerName;
//     data['work_completed'] = workCompleted;
//     data['service_id'] = serviceId;
//     data['service_date'] = serviceDate;
//     data['review'] = review;
//     data['reliability'] = reliability;
//     data['tidiness'] = tidiness;
//     data['response'] = response;
//     data['accuracy'] = accuracy;
//     data['pricing'] = pricing;
//     data['overall_exp'] = overallExp;
//     data['recommend'] = recommend;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }

// class Providerreviews {
//   int? id;
//   String? traderId;
//   String? userId;
//   String? workCompleted;
//   String? serviceId;
//   String? serviceDate;
//   String? review;
//   String? reliability;
//   String? tidiness;
//   String? response;
//   String? accuracy;
//   String? pricing;
//   String? overallExp;
//   String? recommend;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   Getuser? getuser;

//   Providerreviews(
//       {this.id,
//       this.traderId,
//       this.userId,
//       this.workCompleted,
//       this.serviceId,
//       this.serviceDate,
//       this.review,
//       this.reliability,
//       this.tidiness,
//       this.response,
//       this.accuracy,
//       this.pricing,
//       this.overallExp,
//       this.recommend,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.getuser});

//   Providerreviews.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderId = json['trader_id'];
//     userId = json['user_id'];
//     workCompleted = json['work_completed'];
//     serviceId = json['service_id'];
//     serviceDate = json['service_date'];
//     review = json['review'];
//     reliability = json['reliability'];
//     tidiness = json['tidiness'];
//     response = json['response'];
//     accuracy = json['accuracy'];
//     pricing = json['pricing'];
//     overallExp = json['overall_exp'];
//     recommend = json['recommend'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     getuser =
//         json['getuser'] != null ? Getuser.fromJson(json['getuser']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_id'] = traderId;
//     data['user_id'] = userId;
//     data['work_completed'] = workCompleted;
//     data['service_id'] = serviceId;
//     data['service_date'] = serviceDate;
//     data['review'] = review;
//     data['reliability'] = reliability;
//     data['tidiness'] = tidiness;
//     data['response'] = response;
//     data['accuracy'] = accuracy;
//     data['pricing'] = pricing;
//     data['overall_exp'] = overallExp;
//     data['recommend'] = recommend;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (getuser != null) {
//       data['getuser'] = getuser!.toJson();
//     }
//     return data;
//   }
// }

// class Getuser {
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

//   Getuser(
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

//   Getuser.fromJson(Map<String, dynamic> json) {
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

// class Providerfollows {
//   int? id;
//   String? userType;
//   String? userId;
//   String? traderId;
//   String? follow;
//   String? createdAt;
//   String? updatedAt;

//   Providerfollows(
//       {this.id,
//       this.userType,
//       this.userId,
//       this.traderId,
//       this.follow,
//       this.createdAt,
//       this.updatedAt});

//   Providerfollows.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userType = json['user_type'];
//     userId = json['user_id'];
//     traderId = json['trader_id'];
//     follow = json['follow'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_type'] = userType;
//     data['user_id'] = userId;
//     data['trader_id'] = traderId;
//     data['follow'] = follow;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class Providerfavourites {
//   int? id;
//   String? userType;
//   String? userId;
//   String? traderId;
//   String? favourite;
//   String? createdAt;
//   String? updatedAt;

//   Providerfavourites(
//       {this.id,
//       this.userType,
//       this.userId,
//       this.traderId,
//       this.favourite,
//       this.createdAt,
//       this.updatedAt});

//   Providerfavourites.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userType = json['user_type'];
//     userId = json['user_id'];
//     traderId = json['trader_id'];
//     favourite = json['favourite'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_type'] = userType;
//     data['user_id'] = userId;
//     data['trader_id'] = traderId;
//     data['favourite'] = favourite;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class Providerworks {
//   int? id;
//   String? providerId;
//   String? serviceId;
//   String? image;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   Providerworks(
//       {this.id,
//       this.providerId,
//       this.serviceId,
//       this.image,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Providerworks.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     providerId = json['provider_id'];
//     serviceId = json['service_id'];
//     image = json['image'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['provider_id'] = providerId;
//     data['service_id'] = serviceId;
//     data['image'] = image;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class Providerposts {
//   int? id;
//   String? traderId;
//   String? title;
//   String? postContent;
//   String? status;
//   String? emoji;
//   String? likes;
//   String? reactions;
//   String? createdAt;
//   String? updatedAt;
//   List<Traderpostimages>? traderpostimages;

//   Providerposts(
//       {this.id,
//       this.traderId,
//       this.title,
//       this.postContent,
//       this.status,
//       this.emoji,
//       this.likes,
//       this.reactions,
//       this.createdAt,
//       this.updatedAt,
//       this.traderpostimages});

//   Providerposts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderId = json['trader_id'];
//     title = json['title'];
//     postContent = json['post_content'];
//     status = json['status'];
//     emoji = json['emoji'];
//     likes = json['likes'];
//     reactions = json['reactions'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['traderpostimages'] != null) {
//       traderpostimages = <Traderpostimages>[];
//       json['traderpostimages'].forEach((v) {
//         traderpostimages!.add(Traderpostimages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_id'] = traderId;
//     data['title'] = title;
//     data['post_content'] = postContent;
//     data['status'] = status;
//     data['emoji'] = emoji;
//     data['likes'] = likes;
//     data['reactions'] = reactions;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (traderpostimages != null) {
//       data['traderpostimages'] =
//           traderpostimages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Traderpostimages {
//   int? id;
//   String? traderPostId;
//   String? postImage;
//   String? createdAt;
//   String? updatedAt;

//   Traderpostimages(
//       {this.id,
//       this.traderPostId,
//       this.postImage,
//       this.createdAt,
//       this.updatedAt});

//   Traderpostimages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     traderPostId = json['trader_post_id'];
//     postImage = json['post_image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['trader_post_id'] = traderPostId;
//     data['post_image'] = postImage;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class Provideroffers {
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
//   List<Traderofferimages>? traderofferimages;

//   Provideroffers(
//       {this.id,
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
//       this.traderofferimages});

//   Provideroffers.fromJson(Map<String, dynamic> json) {
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
//     if (json['traderofferimages'] != null) {
//       traderofferimages = <Traderofferimages>[];
//       json['traderofferimages'].forEach((v) {
//         traderofferimages!.add(Traderofferimages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
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
