// To parse this JSON data, do
//
//     final tradersCategoryModel = tradersCategoryModelFromJson(jsonString);

class TradersCategoryModel {
  int? id;
  String? mainCategory;
  String? parentCategory;
  String? category;
  String? description;
  String? status;
  String? icon;
  String? createdAt;
  String? updatedAt;

  TradersCategoryModel(
      {this.id,
      this.mainCategory,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.icon,
      this.createdAt,
      this.updatedAt});

  TradersCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategory = json['main_category'];
    parentCategory = json['parent_category'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['main_category'] = mainCategory;
    data['parent_category'] = parentCategory;
    data['category'] = category;
    data['description'] = description;
    data['status'] = status;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
  static List<TradersCategoryModel> categoryfromSnapshot(List snapshot){
    return snapshot.map((snap) => TradersCategoryModel.fromJson(snap)).toList();

  }
}

// import 'dart:convert';

// TradersCategoryModel tradersCategoryModelFromJson(String str) => TradersCategoryModel.fromJson(json.decode(str));

// String tradersCategoryModelToJson(TradersCategoryModel data) => json.encode(data.toJson());

// class TradersCategoryModel {
//   TradersCategoryModel({
//     required this.status,
//     required this.data,
//     required this.message,
//   });

//   int status;
//   List<Datum> data;
//   String message;

//   factory TradersCategoryModel.fromJson(Map<String, dynamic> json) => TradersCategoryModel(
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
//     this.id,
//     this.mainCategory,
//     this.parentCategory,
//     this.category,
//     this.description,
//     this.status,
//     this.icon,
//     this.createdAt,
//     this.updatedAt,
//     this.subcategories,
//   });

//   int? id;
//   MainCategory? mainCategory;
//   String? parentCategory;
//   String? category;
//   String? description;
//   String? status;
//   String? icon;
//   String? createdAt;
//   String? updatedAt;
//   List<Datum>? subcategories;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     mainCategory: mainCategoryValues.map![json["main_category"]],
//     parentCategory: json["parent_category"],
//     category: json["category"],
//     description: json["description"],
//     status: json["status"],
//     icon: json["icon"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//     subcategories: json["subcategories"] == null ? null : List<Datum>.from(json["subcategories"].map((x) => Datum.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "main_category": mainCategoryValues.reverse[mainCategory],
//     "parent_category": parentCategory,
//     "category": category,
//     "description": description,
//     "status": status,
//     "icon": icon,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "subcategories": subcategories == null ? null : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
//   };
// }

// enum MainCategory { SERVICE, SELLER }

// final mainCategoryValues = EnumValues({
//   "Seller": MainCategory.SELLER,
//   "Service": MainCategory.SERVICE
// });

// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
