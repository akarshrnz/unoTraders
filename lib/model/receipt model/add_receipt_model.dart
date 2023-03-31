import 'dart:io';

class AddReceiptModel {
  int? userId;
  String? title;
  String? remarks;
  File? receiptImage;

  AddReceiptModel({this.userId, this.title, this.remarks, this.receiptImage});

  AddReceiptModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    remarks = json['remarks'];
    receiptImage = json['receiptImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['title'] = title;
    data['remarks'] = remarks;
    data['receiptImage'] = receiptImage;
    return data;
  }
}
