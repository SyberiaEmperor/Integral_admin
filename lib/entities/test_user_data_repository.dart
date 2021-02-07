import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/models/user_data_repository.dart';

class TestUserDataRepository extends UserDataRepository {
  @override
  Future<AuthData> getData() async {
    await Future.delayed(Duration(seconds: 3));
    print('TestUserRepository got data');
  }

  @override
  Future<void> setData(AuthData data) {
    print('TestUserRepository set data');
  }
}
