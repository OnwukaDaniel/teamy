import 'package:teamy/imports.dart';

class SignInViewmodel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _visiblePassword = false;
  bool _visibleConfirmPassword = false;
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  bool get visibleConfirmPassword => _visibleConfirmPassword;

  setVisibleConfirmPassword(bool value) {
    _visibleConfirmPassword = value;
    notifyListeners();
  }

  logIn(BuildContext context) async {
    if (!signInFormKey.currentState!.validate()) return;
    setBusy(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final res = await AuthRepo.signIn(email, password);
    setBusy(false);
    switch (res.status) {
      case true:
        if (res.data == null) {
          AppMessage.msg(res.message);
        } else {}
        break;
      case false:
        AppMessage.msg(res.message);
        break;
    }
  }

  signUp(BuildContext context) async {
    if (!signUpFormKey.currentState!.validate()) return;
    setBusy(true);
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final email = emailController.text.trim();
    final rePassword = passwordController.text.trim();
    final res = await AuthRepo.signUp(email, password, name);
    setBusy(false);
    switch (res.status) {
      case true:
        if (res.data == null) {
          AppMessage.msg(res.message);
        } else {}
        break;
      case false:
        AppMessage.msg(res.message);
        break;
    }
  }

  goToSignUp(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => SignUp()));
  }

  goToSignIn(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => SignIn()));
  }
}
