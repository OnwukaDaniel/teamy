import 'package:dio/dio.dart';
import 'package:teamy/imports.dart';

class AuthRepo extends IAuthRepo {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  @override
  Future<UserData?> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/sign_in',
        data: {
          'email': email,
          'password': password,
        },
      );
      final data = response.data['data'];
      if (data != null) {
        return UserData.fromJson(data);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<UserData?> signUp(String email, String password, String name) async {
    try {
      final response = await _dio.post(
        '/auth/sign_up',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );
      final data = response.data['data'];
      if (data != null) {
        return UserData.fromJson(data);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<UserData?> getLocalUser() async {
    try {
      final jsonString = await LocalStorage.getString(Preferences.usersJson);
      return UserData.fromJson(jsonDecode(jsonString));
    } catch (_) {}
    return null;
  }
}
