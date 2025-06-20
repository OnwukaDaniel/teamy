import 'package:teamy/imports.dart';

class SignIn extends StatelessWidget with ThemeHelper, StaticWidgets {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewmodel(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          body: Form(
            key: model.signInFormKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                kToolbarHeight.h,
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (size.height * .05).h,
                      Image.asset('assets/app_icon.png', width: 60, height: 60),
                      24.h,
                      Text('Minimalistic Team', style: tm),
                      (size.height * .05).h,
                    ],
                  ),
                ),
                kToolbarHeight.h,
                Text(
                  'Welcome Back !',
                  style: tm.copyWith(fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                (kToolbarHeight * .5).h,
                input(
                  model,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: model.emailController,
                  validator: ValidatorService.validateEmail,
                ),
                24.h,
                input(
                  model,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: model.passwordController,
                  obscureText: model.visiblePassword,
                  validator: ValidatorService.validatePassword,
                ),
                64.h,
                TextButton(
                  onPressed: () => model.logIn(context),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.appColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child:
                      model.isBusy
                          ? CircularProgressIndicator(color: Colors.white)
                          : Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Sign In',
                              style: bl.copyWith(color: Colors.white),
                            ),
                          ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () => model.goToSignUp(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Don't have an account Sign Up",
                style: bm.copyWith(decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget input(
    SignInViewmodel model, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    String? hint,
    String? Function(String?)? validator,
  }) {
    Widget eyeIcon() {
      return IconButton(
        onPressed: () => model.setVisiblePassword(!obscureText),
        icon: Icon(
          obscureText
              ? Icons.remove_red_eye_outlined
              : Icons.visibility_off_outlined,
        ),
      );
    }

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: border(),
        filled: true,
        hintText: hint,
        fillColor: Colors.grey.withAlpha(40),
        border: border(),
        enabledBorder: border(),
        suffixIcon:
            keyboardType == TextInputType.visiblePassword ? eyeIcon() : null,
      ),
    );
  }
}
