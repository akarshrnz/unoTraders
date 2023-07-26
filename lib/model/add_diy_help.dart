import 'dart:io';

class AddDiyHelp {
  String? title;
  String? diyHelp;
  int? userId;
  String? userType;
  List<File>? images;

  AddDiyHelp(
      {this.title, this.diyHelp, this.userId, this.userType, this.images});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['diy_help'] = diyHelp;
    data['user_id'] = userId;
    data['images'] = images;
    data['user_type'] = userType;
    return data;
  }
}
