import 'package:teamy/imports.dart';

class SignInViewmodel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _visiblePassword = false;
  final signInFormKey = GlobalKey<FormState>();

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  logIn(BuildContext context) async {
    if(!signInFormKey.currentState!.validate()) return;
    setBusy(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final res = await AuthRepo.signIn(email, password);
    setBusy(false);
    switch (res.status) {
      case true:
        if (res.data == null) {
          AppMessage.msg(res.message);
        } else {

        }
        break;
      case false:
        AppMessage.msg(res.message);
    }
  }
}
