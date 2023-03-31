class RemoveReceipt {
  String? userType;
  int? userId;
  int? receiptId;

  RemoveReceipt({this.userType, this.userId, this.receiptId});

  RemoveReceipt.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    userId = json['userId'];
    receiptId = json['receiptId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = userType;
    data['userId'] = userId;
    data['receiptId'] = receiptId;
    return data;
  }
}
