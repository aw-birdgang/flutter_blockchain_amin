import '../../models/token.dart';

abstract class IrepositoryToken {
  Future<List<Token>> getTokens();
  Future<Token> createToken(Token token);
  Future<void> updateTokenStatus(String tokenId, String statusValue);
}
