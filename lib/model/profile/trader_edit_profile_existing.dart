import 'dart:io';

class TraderEditProfileExistingdata {
  int? status;
  Data? data;
  String? message;

  TraderEditProfileExistingdata({this.status, this.data, this.message});

  TraderEditProfileExistingdata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Providerdocuments>? providerdocuments;
  List<Providerservices>? providerservices;
  List<Providerworks>? providerworks;
  List<Providercategories>? providercategories;
  List<Providersubcategories>? providersubcategories;

  Data(
      {this.providerdocuments,
      this.providerservices,
      this.providerworks,
      this.providercategories,
      this.providersubcategories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['providerdocuments'] != null) {
      providerdocuments = <Providerdocuments>[];
      json['providerdocuments'].forEach((v) {
        providerdocuments!.add(new Providerdocuments.fromJson(v));
      });
    }
    if (json['providerservices'] != null) {
      providerservices = <Providerservices>[];
      json['providerservices'].forEach((v) {
        providerservices!.add(new Providerservices.fromJson(v));
      });
    }
    if (json['providerworks'] != null) {
      providerworks = <Providerworks>[];
      json['providerworks'].forEach((v) {
        providerworks!.add(new Providerworks.fromJson(v));
      });
    }
    if (json['providercategories'] != null) {
      providercategories = <Providercategories>[];
      json['providercategories'].forEach((v) {
        providercategories!.add(new Providercategories.fromJson(v));
      });
    }
    if (json['providersubcategories'] != null) {
      providersubcategories = <Providersubcategories>[];
      json['providersubcategories'].forEach((v) {
        providersubcategories!.add(new Providersubcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providerdocuments != null) {
      data['providerdocuments'] =
          this.providerdocuments!.map((v) => v.toJson()).toList();
    }
    if (this.providerservices != null) {
      data['providerservices'] =
          this.providerservices!.map((v) => v.toJson()).toList();
    }
    if (this.providerworks != null) {
      data['providerworks'] =
          this.providerworks!.map((v) => v.toJson()).toList();
    }
    if (this.providercategories != null) {
      data['providercategories'] =
          this.providercategories!.map((v) => v.toJson()).toList();
    }
    if (this.providersubcategories != null) {
      data['providersubcategories'] =
          this.providersubcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providerdocuments {
  int? id;
  String? proofType;
  String? idType;
  String? idNumber;
  String? document;
  int? verified;
  int? status;

  Providerdocuments(
      {this.id,
      this.proofType,
      this.idType,
      this.idNumber,
      this.document,
      this.verified,
      this.status});

  Providerdocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proofType = json['proof_type'];
    idType = json['id_type'];
    idNumber = json['id_number'];
    document = json['document'];
    verified = json['verified'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['proof_type'] = this.proofType;
    data['id_type'] = this.idType;
    data['id_number'] = this.idNumber;
    data['document'] = this.document;
    data['verified'] = this.verified;
    data['status'] = this.status;
    return data;
  }
}

class Providerservices {
  int? id;
  int? serviceId;
  String? name;
  int? status;

  Providerservices({this.id, this.serviceId, this.name, this.status});

  Providerservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class Providerworks {
  int? id;
  int? serviceId;
  String? image;
  int? status;
  bool? isNetworkImage;
  File? fileImage;

  Providerworks(
      {this.id,
      this.serviceId,
      this.image,
      this.status,
      this.isNetworkImage,
      this.fileImage});

  Providerworks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    image = json['image'];
    status = json['status'];
    isNetworkImage = true;
    fileImage = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class Providercategories {
  int? id;
  int? categoryId;
  String? name;
  int? status;

  Providercategories({this.id, this.categoryId, this.name, this.status});

  Providercategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class Providersubcategories {
  int? id;
  int? subCategoryId;
  String? name;
  int? status;

  Providersubcategories({this.id, this.subCategoryId, this.name, this.status});

  Providersubcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}




// import 'dart:io';

// class TraderEditProfileExistingdata {
//   List<Providerdocuments>? providerdocuments;
//   List<Providerservices>? providerservices;
//   List<Providerworks>? providerworks;
//   List<Providercategories>? providercategories;
//   List<Providersubcategories>? providersubcategories;

//   TraderEditProfileExistingdata(
//       {this.providerdocuments,
//       this.providerservices,
//       this.providerworks,
//       this.providercategories,
//       this.providersubcategories});

//   TraderEditProfileExistingdata.fromJson(Map<String, dynamic> json) {
//     if (json['providerdocuments'] != null) {
//       providerdocuments = <Providerdocuments>[];
//       json['providerdocuments'].forEach((v) {
//         providerdocuments!.add(new Providerdocuments.fromJson(v));
//       });
//     }
//     if (json['providerservices'] != null) {
//       providerservices = <Providerservices>[];
//       json['providerservices'].forEach((v) {
//         providerservices!.add(new Providerservices.fromJson(v));
//       });
//     }
//     if (json['providerworks'] != null) {
//       providerworks = <Providerworks>[];
//       json['providerworks'].forEach((v) {
//         providerworks!.add(new Providerworks.fromJson(v));
//       });
//     }
//     if (json['providercategories'] != null) {
//       providercategories = <Providercategories>[];
//       json['providercategories'].forEach((v) {
//         providercategories!.add(new Providercategories.fromJson(v));
//       });
//     }
//     if (json['providersubcategories'] != null) {
//       providersubcategories = <Providersubcategories>[];
//       json['providersubcategories'].forEach((v) {
//         providersubcategories!.add(new Providersubcategories.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (providerdocuments != null) {
//       data['providerdocuments'] =
//           providerdocuments!.map((v) => v.toJson()).toList();
//     }
//     if (providerservices != null) {
//       data['providerservices'] =
//           providerservices!.map((v) => v.toJson()).toList();
//     }
//     if (providerworks != null) {
//       data['providerworks'] = providerworks!.map((v) => v.toJson()).toList();
//     }
//     if (providercategories != null) {
//       data['providercategories'] =
//           providercategories!.map((v) => v.toJson()).toList();
//     }
//     if (providersubcategories != null) {
//       data['providersubcategories'] =
//           providersubcategories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Providerdocuments {
//   int? id;
//   String? proofType;
//   String? idType;
//   String? idNumber;
//   String? document;
//   int? verified;
//   int? status;

//   Providerdocuments(
//       {this.id,
//       this.proofType,
//       this.idType,
//       this.idNumber,
//       this.document,
//       this.verified,
//       this.status});

//   Providerdocuments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     proofType = json['proof_type'];
//     idType = json['id_type'];
//     idNumber = json['id_number'];
//     document = json['document'];
//     verified = json['verified'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['proof_type'] = proofType;
//     data['id_type'] = idType;
//     data['id_number'] = idNumber;
//     data['document'] = document;
//     data['verified'] = verified;
//     data['status'] = status;
//     return data;
//   }
// }

// class Providerservices {
//   int? id;
//   int? serviceId;
//   String? name;
//   int? status;

//   Providerservices({this.id, this.serviceId, this.name, this.status});

//   Providerservices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceId = json['service_id'];
//     name = json['name'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['service_id'] = serviceId;
//     data['name'] = name;
//     data['status'] = status;
//     return data;
//   }
// }

// class Providerworks {
//   int? id;
//   int? serviceId;
//   String? image;
//   int? status;
  // bool? isNetworkImage;
  // File? fileImage;

  // Providerworks(
  //     {this.id,
  //     this.serviceId,
  //     this.image,
  //     this.status,
  //     this.isNetworkImage,
  //     this.fileImage});

  // Providerworks.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   serviceId = json['service_id'];
  //   image = json['image'];
  //   status = json['status'];
  //   isNetworkImage = true;
  //   fileImage = null;
  // }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['service_id'] = serviceId;
//     data['image'] = image;
//     data['status'] = status;
//     return data;
//   }
// }

// class Providercategories {
//   int? id;
//   int? categoryId;
//   String? name;
//   int? status;

//   Providercategories({this.id, this.categoryId, this.name, this.status});

//   Providercategories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     categoryId = json['category_id'];
//     name = json['name'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['category_id'] = categoryId;
//     data['name'] = name;
//     data['status'] = status;
//     return data;
//   }
// }

// class Providersubcategories {
//   int? id;
//   int? subCategoryId;
//   String? name;
//   int? status;

//   Providersubcategories({this.id, this.subCategoryId, this.name, this.status});

//   Providersubcategories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     subCategoryId = json['sub_category_id'];
//     name = json['name'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['sub_category_id'] = subCategoryId;
//     data['name'] = name;
//     data['status'] = status;
//     return data;
//   }
// }
