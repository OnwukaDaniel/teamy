import 'package:flutter/scheduler.dart';
import 'package:teamy/imports.dart';

class SplashScreen extends StatelessWidget with ThemeHelper {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final largeSide = size.width > size.height ? size.width : size.height;
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignIn()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/app_icon.png',
            width: largeSide,
            height: largeSide,
            opacity: Animation.fromValueListenable(ValueNotifier(.6)),
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/app_icon.png', width: 130, height: 130),
                20.h,
                Text(
                  'Teamy',
                  style: tl.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
