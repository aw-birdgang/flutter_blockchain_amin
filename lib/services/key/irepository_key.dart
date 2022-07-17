import '../../models/kmsKey.dart';

abstract class IrepositoryKey {
  Future<List<KmsKey>> getKeys();
  Future<dynamic> encryptKey(name, type);
}