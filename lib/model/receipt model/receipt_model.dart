class ReceiptModel {
  int? id;
  String? userType;
  int? userId;
  String? title;
  String? remarks;
  int? status;
  String? receiptImage;
  String? createdAt;
  String? updatedAt;

  ReceiptModel(
      {this.id,
      this.userType,
      this.userId,
      this.title,
      this.remarks,
      this.status,
      this.receiptImage,
      this.createdAt,
      this.updatedAt});

  static List<ReceiptModel> snapshot(List snapshot) {
    return snapshot.map((snap) => ReceiptModel.fromJson(snap)).toList();
  }

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    title = json['title'];
    remarks = json['remarks'];
    status = json['status'];
    receiptImage = json['receipt_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user_type'] = this.userType;
  //   data['user_id'] = this.userId;
  //   data['title'] = this.title;
  //   data['remarks'] = this.remarks;
  //   data['status'] = this.status;
  //   data['receipt_image'] = this.receiptImage;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
