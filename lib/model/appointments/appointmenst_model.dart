class AddAppointmentModel {
  int? traderId;
  int? customerId;
  String? appointmentDate;
  String? appointmentTime;
  String? remarks;

  AddAppointmentModel(
      {this.traderId,
      this.customerId,
      this.appointmentDate,
      this.appointmentTime,
      this.remarks});

  AddAppointmentModel.fromJson(Map<String, dynamic> json) {
    traderId = json['traderId'];
    customerId = json['customerId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traderId'] = traderId;
    data['customerId'] = customerId;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['remarks'] = remarks;
    return data;
  }
}
