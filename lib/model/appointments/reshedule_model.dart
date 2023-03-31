class RescheduleModel {
  String? status;
  String? remarks;
  String? appointmentTime;
  String? appointmentDate;
  String? appointmentId;

  RescheduleModel(
      {this.status,
      this.remarks,
      this.appointmentTime,
      this.appointmentDate,
      this.appointmentId});

  RescheduleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    remarks = json['remarks'];
    appointmentId = json['appointment_id'];
    appointmentTime = json['appointmentTime'];
    appointmentDate = json['appointmentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['remarks'] = remarks;
    data['appointment_id'] = appointmentId;
    data['appointmentTime'] = appointmentTime;
    data['appointmentDate'] = appointmentDate;
    return data;
  }
}
