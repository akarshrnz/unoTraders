class NotificationModel {
  String? notification;
  String? time;

  NotificationModel({this.notification, this.time});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notification'] = notification;
    data['time'] = time;
    return data;
  }

  static List<NotificationModel> snapshot(List snapshot) {
    return snapshot.map((snap) => NotificationModel.fromJson(snap)).toList();
  }
}
