class RegisterModel {
  String? userType;
  String? traderType;
  String? name;
  String? email;
  String? userName;
  String? mobile;
  String? password;
  String? confirmPassword;

  RegisterModel(
      {this.userType,
      this.traderType,
      this.name,
      this.email,
      this.userName,
      this.mobile,
      this.password,
      this.confirmPassword});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    traderType = json['traderType'];
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    mobile = json['mobile'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = userType;
    data['traderType'] = traderType;
    data['name'] = name;
    data['email'] = email;
    data['userName'] = userName;
    data['mobile'] = mobile;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}
