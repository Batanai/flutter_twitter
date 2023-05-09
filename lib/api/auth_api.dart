
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/core/core.dart';
import 'package:twitterclone/core/providers.dart';

final authProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthApi(account: account);
});

abstract class IAuthApi{

  FutureEither<model.User> signUp({
    required String email,
    required String password
  });

  FutureEither<model.Session> login({
    required String email,
    required String password
  });

  Future<model.User?> currentUserAccount ();
}

class AuthApi implements IAuthApi {
  final Account _account;
  AuthApi({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp({
    required String email, 
    required String password
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(), 
        email: email, 
        password: password
      );
    return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occured', stackTrace)
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace)
      );
    }
  }
  
  @override
  FutureEither<model.Session> login({
    required String email, 
    required String password
  }) async {
   try {
     final session = await _account.createEmailSession(
      email: email, 
      password: password
    );
    return right(session);
   } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occured', stackTrace)
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace)
      );
    }
  }

}