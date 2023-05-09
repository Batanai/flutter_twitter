import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';
import 'package:twitterclone/features/home/view/home.dart';
import 'package:appwrite/models.dart' as model;
import '../../../api/auth_api.dart';
import '../../../core/core.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApi: ref.watch(authProvider));
});

final currentUserProvider = FutureProvider((ref) async {
  final authConttroller = ref.watch(authControllerProvider.notifier);
  return authConttroller.ccurrentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi}): 
  _authApi = authApi, 
  super(false);

  //state = isLoading
  Future<model.User?> ccurrentUser () => _authApi.currentUserAccount();
  
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
      (r) {
        print(r.email);
        showSnackBar(context, 'Account creatted: Please login');
        Navigator.push(context, LoginView.route());
      } 
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
      (r) {
        print(r.userId);
        showSnackBar(context, 'Login was successful');
        Navigator.push(context, HomeView.route());
      } 
    );
  }
}