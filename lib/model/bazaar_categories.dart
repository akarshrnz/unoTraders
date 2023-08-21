class BazaarCategories {
  int? id;
  String? parentCategory;
  String? category;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Subcategories>? subcategories;

  BazaarCategories(
      {this.id,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subcategories});

  BazaarCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCategory = json['parent_category'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_category'] = parentCategory;
    data['category'] = category;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  static List<BazaarCategories> bazaarCatListSnap(List snapshot){
    return snapshot.map((snap) => BazaarCategories.fromJson(snap)).toList();

  }
}

class Subcategories {
  int? id;
  String? parentCategory;
  String? category;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Subcategories(
      {this.id,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCategory = json['parent_category'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_category'] = parentCategory;
    data['category'] = category;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
