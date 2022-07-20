import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/token.dart';
import '../log/custom_logInterceptor.dart';
import 'irepository_token.dart';

class RepositoryToken implements IrepositoryToken {

  @override
  Future<List<Token>> getTokens() async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/tokens';
    print('getTokens > url :: ' + url);
    Dio dio = Dio();

    Response response = await dio.get('$api/v1/tokens');
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    // CustomLog
    dio.interceptors.add(CustomLogInterceptor());
    print('getTokens > response.data :: ' + response.toString());
    List<Token> tokens = (response.data as List)
        .map((x) => Token.fromJson(x))
        .toList();
    print('getTokens > tokens.length.toString() :: ' + tokens.length.toString());
    return tokens;
  }

  @override
  Future<void> updateTokenStatus(String tokenId, String statusValue) {
    throw UnimplementedError();
  }

  @override
  Future<Token> createToken(Token token) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/tokens';
    print('createToken > url :: ' + url);
    Dio dio = Dio();

    var formData = FormData.fromMap({
      'symbol': token.symbol,
      'name': token.name,
      'totalSupply': token.totalSupply,
      'decimals': token.decimals,
      'type': token.type,
      'exposeYn': token.exposeYn == true ? 1 : 0,
    });
    print('createToken > formData.toString() :: ' + formData.toString());
    Response response = await dio.post(url, data: formData);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        String apiKey = dotenv.get('API_KEY');
        print('createToken > apiKey :: ' + apiKey);
        // 매 요청마다 헤더에 AccessToken을 포함
        options.headers['Authorization'] = 'Bearer $apiKey';
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    dio.interceptors.add(CustomLogInterceptor());
    return Token.fromJson(response.data);
  }

}