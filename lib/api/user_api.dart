import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/constants/constants.dart';
import 'package:twitterclone/models/user_model.dart';
import '../core/core.dart';
import 'package:appwrite/models.dart' as model;


final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI{
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;
  
  @override
  FutureVoid saveUserData(UserModel userModel) async {
    try {
      await  _db.createDocument(
        databaseId: AppwriteConstants.databaseId, 
        collectionId: AppwriteConstants.usersCollection, 
        documentId: userModel.uid, 
        data: userModel.toMap()
      );

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'Some unexpected error occured', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
  
  @override
  Future<model.Document> getUserData(String uid) async {
    return await _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid,
    );
  }


}