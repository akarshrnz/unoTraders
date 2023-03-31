class AllSubCategoryModel {
  String? id;
  String? mainCategory;
  String? parentCategory;
  String? category;
  String? description;

  String? icon;
  String? createdAt;
  String? updatedAt;

  AllSubCategoryModel(
      {this.id,
      this.mainCategory,
      this.parentCategory,
      this.category,
      this.description,
      this.icon,
      this.createdAt,
      this.updatedAt});
  static List<AllSubCategoryModel> snapshot(List snapshot) {
    return snapshot.map((snap) => AllSubCategoryModel.fromJson(snap)).toList();
  }

  AllSubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    mainCategory = json['main_category'];
    parentCategory = json['parent_category'].toString();
    category = json['category'];
    description = json['description'];

    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main_category'] = mainCategory;
    data['parent_category'] = parentCategory;
    data['category'] = category;
    data['description'] = description;

    data['icon'] = icon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
