// import 'package:parcial_final/models/login_type.dart';

class User {
  String email = '';
  String id = '';
  int loginType = 0;
  String fullName = '';
  String firstName = '';
  String lastName = '';

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.loginType,
    required this.fullName,
    required this.id,
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    loginType = json['loginType'];
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['loginType'] = this.loginType;
    data['fullName'] = this.fullName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
