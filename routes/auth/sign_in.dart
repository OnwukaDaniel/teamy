

import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:teamy/domain/services/auth_service.dart';
import 'package:teamy/repo/auth_repo.dart';

final service = AuthService(AuthRepo());

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.body();
  final data = jsonDecode(body);
  final result = await service.signIn(data['email'], data['password']);
  return Response.json(body: result);
}
