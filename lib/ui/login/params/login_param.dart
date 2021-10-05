
class LoginParam {
  LoginParam({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginParam.fromJson(Map<String, dynamic> json) => LoginParam(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
