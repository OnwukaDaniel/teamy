import 'package:teamy/imports.dart';

class SignInViewmodel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _visiblePassword = false;

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  logIn(BuildContext context) async {
    setBusy(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final res = await AuthRepo.signIn(email, password);
    setBusy(false);
    if(res.status) {
      if(res.data) AppMessage.msg(res.message);
    } else {
      AppMessage.msg(res.message);
    }
  }
}
