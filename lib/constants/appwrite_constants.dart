class AppwriteConstants {
  static const String databaseId = '6442d9230f139e36b801';
  static const String projectId = '64428c6363394b2b4401';
  static const String endpoint = 'http://localhost:80/v1';

  static const String usersCollection = '645c755484b4f2ed28f1';
  static const String tweetsCollection = '6465be30d8a62bc83d2f';
  
  static const String imagesBucket = '646850da4402019e5ac4'; 

  static String imageUrl(String imageId) => '$endpoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}