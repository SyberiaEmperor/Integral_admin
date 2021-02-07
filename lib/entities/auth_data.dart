import 'package:flutter/foundation.dart';
import 'package:integral_admin/resources/app_strings.dart';

class AuthData {
  final String login;
  final String password;

  AuthData({@required this.login, @required this.password});
  Map<String, String> toJson() {
    return {AppAuthStrings.LOGIN: login, AppAuthStrings.PASSWORD: password};
  }

  factory AuthData.fromJson(Map<String, dynamic> data) {
    String login = data[AppAuthStrings.LOGIN] as String;
    String password = data[AppAuthStrings.PASSWORD] as String;
  }
}
