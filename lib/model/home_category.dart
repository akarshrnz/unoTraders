class CategoryAndSubListModel {
  int? id;
  String? mainCategory;
  String? parentCategory;
  String? category;
  String? description;
  String? status;
  String? icon;
  String? createdAt;
  String? updatedAt;
  List<Subcategories>? subcategories;

  CategoryAndSubListModel(
      {this.id,
      this.mainCategory,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.subcategories});
  static List<CategoryAndSubListModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => CategoryAndSubListModel.fromJson(snap))
        .toList();
  }

  CategoryAndSubListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategory = json['main_category'];
    parentCategory = json['parent_category'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['main_category'] = this.mainCategory;
    data['parent_category'] = this.parentCategory;
    data['category'] = this.category;
    data['description'] = this.description;
    data['status'] = this.status;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? id;
  String? mainCategory;
  int? parentCategory;
  String? category;
  String? description;
  int? status;
  String? icon;
  String? createdAt;
  String? updatedAt;

  Subcategories(
      {this.id,
      this.mainCategory,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.icon,
      this.createdAt,
      this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main_category'] = this.mainCategory;
    data['parent_category'] = this.parentCategory;
    data['category'] = this.category;
    data['description'] = this.description;
    data['status'] = this.status;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
