import 'package:teamy/imports.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeData,
      builder: (context, value, _) {
        return OverlaySupport.global(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Teamy',
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            theme: value,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}