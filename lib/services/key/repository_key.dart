import 'package:dio/dio.dart';
import 'package:flutter_blockchain_amin/models/kmsKey.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../log/custom_logInterceptor.dart';
import 'irepository_key.dart';

class RepositoryKey implements IrepositoryKey {

  @override
  Future encryptKey(name, type) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/auth/auth/register';
    print('encryptKey > url :: ' + url);
    Dio dio = Dio();
    var formData = FormData.fromMap({
      'name': name,
      'type': type,
    });
    Response response = await dio.post(url, data: formData);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    dio.interceptors.add(CustomLogInterceptor());
    print('encryptKey > response.data :: ' + response.toString());
  }

  @override
  Future<List<KmsKey>> getKeys() async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/key/keyring';
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