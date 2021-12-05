import 'package:final_distribuida/models/user.dart';

class Token {
  String token = '';
  String expiration = '';
  User user = User(
    email: '',
    id: '',
    loginType: 0,
    fullName: '',
    firstName: '',
    lastName: '',
  );

  Token({required this.token, required this.expiration, required this.user});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    data['user'] = this.user.toJson();
    return data;
  }
}
