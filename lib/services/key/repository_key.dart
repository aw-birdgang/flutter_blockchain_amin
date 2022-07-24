import 'package:dio/dio.dart';
import 'package:flutter_blockchain_amin/models/kmsKey.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../log/custom_logInterceptor.dart';
import 'irepository_key.dart';

class RepositoryKey implements IrepositoryKey {

  @override
  Future encryptKey(KmsKey request,) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/key/encrypt';
    print('encryptKey > url :: ' + url);
    String apiKey = dotenv.get('API_KEY');
    print('encryptKey > apiKey :: ' + apiKey);
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async {
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
    Response response = await dio.post(url, data: request.toMap());
    print('encryptKey > response.data :: ' + response.toString());
    return KmsKey.fromJson(response.data);
  }

  @override
  Future<List<KmsKey>> getKeys() async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/key';
    print('getKeys > url :: ' + url);
    Dio dio = Dio();

    Response response = await dio.get(url);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    // CustomLog
    dio.interceptors.add(CustomLogInterceptor());
    print('getKeys > response.data :: ' + response.toString());
    List<KmsKey> keys = (response.data as List)
        .map((x) => KmsKey.fromJson(x))
        .toList();
    print('getKeys > keys.length.toString() :: ' + keys.length.toString());
    return keys;
  }

}
