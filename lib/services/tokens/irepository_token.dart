import '../../models/token.dart';

abstract class IrepositoryToken {
  Future<List<Token>> getTokens();
  Future<void> updateTokenStatus(String tokenId, String statusValue);
}
