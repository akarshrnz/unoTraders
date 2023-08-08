class ResetPasswordModel {
  int? userId;
  String? userType;
  String? oldPassword;
  String? password;
  String? passwordConfirmation;

  ResetPasswordModel(
      {this.userId,
      this.userType,
      this.oldPassword,
      this.password,
      this.passwordConfirmation});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    oldPassword = json['old_password'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['old_password'] = oldPassword;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
