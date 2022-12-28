class TraderSubCategory {
  int? id;
  String? mainCategory;
  String? parentCategory;
  String? category;
  String? description;
  String? status;
  String? icon;
  String? createdAt;
  String? updatedAt;

  TraderSubCategory(
      {this.id,
      this.mainCategory,
      this.parentCategory,
      this.category,
      this.description,
      this.status,
      this.icon,
      this.createdAt,
      this.updatedAt});

  TraderSubCategory.fromJson(Map<String, dynamic> json) {
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
  static List<TraderSubCategory> subCategoryfromSnapshot(List snapshot){
    return snapshot.map((snap) => TraderSubCategory.fromJson(snap)).toList();

  }
}