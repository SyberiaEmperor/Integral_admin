import 'package:integral_admin/entities/auth_data.dart';

///Local repository, which contains user's data
abstract class UserDataRepository {
  Future<AuthData?> getData();
  Future<void>? setData(AuthData data);
}
