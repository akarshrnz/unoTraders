class GetCustomerAppointmentsModel {
  int? id;
  int? userId;
  int? traderId;
  String? appointmentDate;
  String? appointmentTime;
  String? remarks;
  String? status;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  GetCustomerAppointmentsModel(
      {this.id,
      this.userId,
      this.traderId,
      this.appointmentDate,
      this.appointmentTime,
      this.remarks,
      this.status,
      this.name,
      this.createdAt,
      this.updatedAt});

  static List<GetCustomerAppointmentsModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => GetCustomerAppointmentsModel.fromJson(snap))
        .toList();
  }

  GetCustomerAppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    remarks = json['remarks'];
    image = json['profile_pic'];
    status = json['status'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['trader_id'] = traderId;
    data['appointment_date'] = appointmentDate;
    data['appointment_time'] = appointmentTime;
    data['remarks'] = remarks;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
