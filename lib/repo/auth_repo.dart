import 'package:teamy/imports.dart';

class AuthRepo {
  static Future<NetworkData> signIn(String email, String password) async {
    try {
      final jsonString = await LocalStorage.getStringList(Preferences.usersListJson);
      '$jsonString'.log;
      final data = jsonString.map((e) => UserData.fromJson(jsonDecode(e))).toList();
      final users = data.where(
        (e) => e.email == email && e.password == password,
      );
      if (users.isEmpty) {
        return NetworkData(
          status: true,
          data: null,
          message: 'Invalid credentials',
        );
      }
      return NetworkData(status: true, data: users.first, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Unable to sign in. $e');
    }
  }

  static Future<NetworkData> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      final jsonString = await LocalStorage.getStringList(Preferences.usersListJson);
      if (jsonString.isNotEmpty) {
        final data =
            jsonString.map((e) => UserData.fromJson(jsonDecode(e))).toList();
        final users = data.where(
          (e) => e.email == email && e.password == password,
        );
        if (users.isNotEmpty) {
          return NetworkData(
            status: true,
            data: null,
            message: 'Credentials exist',
          );
        } else {
          final user = _createUser(email, password, name);
          return NetworkData(status: true, data: user, message: 'Success');
        }
      } else {
        final user = _createUser(email, password, name);
        return NetworkData(status: true, data: user, message: 'Success');
      }
    } catch (e) {
      return NetworkData(message: 'Unable to sign in. $e');
    }
  }

  static UserData _createUser(String email, String password, String name) {
    return UserData(
      id: 'User_${DateTime.now().toIso8601String()}',
      name: name,
      email: email,
      password: password,
    );
  }

  static Future<UserData?> getLocalUser() async {
    try {
      final jsonString = await LocalStorage.getString(Preferences.usersJson);
      return UserData.fromJson(jsonDecode(jsonString));
    } catch (e) {}
    return null;
  }
}
