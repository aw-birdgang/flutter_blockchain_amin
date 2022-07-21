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
    print('createToken > token.toString() :: ' + token.toString());
    String apiKey = dotenv.get('API_KEY');
    print('createToken > apiKey :: ' + apiKey);
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) async {
        // 매 요청마다 헤더에 AccessToken을 포함
        options.headers['Authorization'] = 'Bearer $apiKey';
        return handler.next(options); //continue
      },
      onResponse:(response,handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) {
        print('createToken > error.message :: ' + error.message);
        return  handler.next(error);
      }
    ));
    // dio.interceptors.add(CustomLogInterceptor());
    Response response = await dio.post(url, data: token.toMap());
    return Token.fromJson(response.data);
  }

}