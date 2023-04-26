import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../api/auth_api.dart';
import '../../../core/core.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApi: ref.watch(authProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi}): 
  _authApi = authApi, 
  super(false);

  //state = isLoading
  
  void signUp({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    state = true;
    final res = await _authApi.signUp(email: email, password: password);
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.message), 
      (r) => print(r.email)
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    state = true;
    final res = await _authApi.login(email: email, password: password);
    state = false;

    res.fold(
      (l) => showSnackBar(context, l.message), 
      (r) => print(r.userId)
    );
  }
}