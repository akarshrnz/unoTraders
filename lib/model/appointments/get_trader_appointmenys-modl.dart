class GetTraderAppointmentModel {
  int? id;
  int? userId;
  int? traderId;
  String? appointmentDate;
  String? appointmentTime;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profilePic;

  GetTraderAppointmentModel(
      {this.id,
      this.userId,
      this.traderId,
      this.appointmentDate,
      this.appointmentTime,
      this.remarks,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profilePic});
  static List<GetTraderAppointmentModel> snapshot(List snapshot) {
    return snapshot
        .map((snap) => GetTraderAppointmentModel.fromJson(snap))
        .toList();
  }

  GetTraderAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    traderId = json['trader_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    profilePic = json['profile_pic'];
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
    data['name'] = name;
    data['profile_pic'] = profilePic;
    return data;
  }
}
