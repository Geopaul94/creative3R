class UserAuthenticationModel {
  String phonenumber;
  String password;

  UserAuthenticationModel({required this.phonenumber, required this.password});

  factory UserAuthenticationModel.fromJson(Map<String, dynamic> json) {
    return UserAuthenticationModel(
      phonenumber: json['phonenumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phonenumber': phonenumber,
      'password': password,
    };
  }
}




