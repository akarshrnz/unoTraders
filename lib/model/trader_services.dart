class TraderServices {
  int? id;
  int? category;
  int? subCategory;
  String? service;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  TraderServices(
      {this.id,
      this.category,
      this.subCategory,
      this.service,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  TraderServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subCategory = json['sub_category'];
    service = json['service'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['service'] = service;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<TraderServices> snapshot(List snapshot) {
    return snapshot.map((snap) => TraderServices.fromJson(snap)).toList();
  }
}
