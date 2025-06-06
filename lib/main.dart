import 'package:teamy/imports.dart';

//import 'middleware/logger.dart';

Handler middleware(Handler handler) {
  return handler.use(logger());
}

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //LocalStorage.clear();
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