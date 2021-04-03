import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/models/user_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpDataRepository implements UserDataRepository {
  static const _login = 'login';
  static const _password = 'password';

  @override
  Future<AuthData?> getData() async {
    var prefs = await SharedPreferences.getInstance();
    String? login = prefs.getString(_login);
    String? password = prefs.getString(_password);
    if (login != null && password != null) {
      return AuthData(login: login, password: password);
    }
    return null;
  }

  @override
  Future<void>? setData(AuthData data) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_login, data.login!);
    await prefs.setString(_password, data.password!);
  }
}
