import 'package:teamy/imports.dart';

Middleware logger() {
  return (handler) {
    return (context) async {
      final request = context.request;
      debugPrint('[${DateTime.now()}] ${request.method} ${request.uri}');
      return handler(context);
    };
  };
}