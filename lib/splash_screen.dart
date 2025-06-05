import 'package:teamy/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ThemeHelper {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  navigate() {
    Future.delayed(Duration(seconds: 2), () async {
      if (!context.mounted) return;
      final jsonString = await LocalStorage.getString(Preferences.usersJson);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => jsonString.isEmpty ? SignIn() : Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final largeSide = size.width > size.height ? size.width : size.height;

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
