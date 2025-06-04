import 'package:teamy/imports.dart';

class AuthRepo {
  static Future<NetworkData> signIn(String email, String password) async {
    try {
      final jsonString = LocalStorage.getStringList(Preferences.userJson);
      final data = jsonString.map((e) => jsonDecode(e) as UserData).toList();
      final users = data.where((e) => e.email == email && e.password == password);
      if(users.isEmpty) {
        return NetworkData(status: true, data: null, message: 'Invalid credentials');
      }
      return NetworkData(status: true, data: data);
    } catch (e) {
      return NetworkData(message: 'Unable to sign in. $e');
    }
  }

  static Future<NetworkData> signUp(String email, String password, String name) async {
    try {
      final jsonString = LocalStorage.getStringList(Preferences.userJson);
      final data = jsonString.map((e) => jsonDecode(e) as UserData).toList();
      final users = data.where((e) => e.email == email && e.password == password);
      if(users.isEmpty) {
        return NetworkData(status: true, data: null, message: 'Invalid credentials');
      }
      return NetworkData(status: true, data: data);
    } catch (e) {
      return NetworkData(message: 'Unable to sign in. $e');
    }
  }
}
