import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/api/user_api.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';
import 'package:twitterclone/features/home/view/home.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitterclone/models/user_model.dart';
import '../../../api/auth_api.dart';
import '../../../core/core.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApi: ref.watch(authProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserAPI _userAPI;
  AuthController({required AuthApi authApi, required UserAPI userAPI}): 
  _authApi = authApi,
  _userAPI = userAPI,
  super(false);

  //state = isLoading
  Future<model.User?> currentUser () => _authApi.currentUserAccount();
  
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
      (r) async {
        UserModel userModel = UserModel(
          email: email, 
          name: getNameFromEmail(email), 
          followers: const [], 
          following: const [], 
          profilePic: '', 
          bannerPic: '', 
          uid: r.$id, 
          bio: '', 
          isTwitterBlue: false);
        
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold(
          (l) => showSnackBar(context, l.message), 
          (r) {
            showSnackBar(context, 'Account created! Please login');
            Navigator.push(context, LoginView.route());
          });     
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
        print('Auth controller on login success');
        print(r.userId);
        showSnackBar(context, 'Login was successful');
        Navigator.push(context, HomeView.route());
      } 
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}