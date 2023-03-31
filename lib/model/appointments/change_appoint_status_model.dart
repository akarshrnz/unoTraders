class ChangeAppointmentStatusModel {
  int? appointmentId;
  String? status;
  String? remarks;

  ChangeAppointmentStatusModel({this.appointmentId, this.status, this.remarks});

  ChangeAppointmentStatusModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    status = json['status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['status'] = status;
    data['remarks'] = remarks;
    return data;
  }
}
