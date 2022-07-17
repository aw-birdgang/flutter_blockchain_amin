import 'package:dio/dio.dart';
import 'package:flutter_blockchain_amin/models/host.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../log/custom_logInterceptor.dart';
import 'irepository_host.dart';

class RepositoryHost implements IrepositoryHost {

  @override
  Future registerHost(name, type) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/auth/auth/register';
    print('registerHost > url :: ' + url);
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
    print('registerHost > response.data :: ' + response.toString());
  }

  @override
  Future<List<Host>> getHosts() async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/users';
    print('getHosts > url :: ' + url);
    Dio dio = Dio();

    Response response = await dio.get(url);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    // CustomLog
    dio.interceptors.add(CustomLogInterceptor());
    print('getHosts > response.data :: ' + response.toString());
    List<Host> hosts = (response.data as List)
        .map((x) => Host.fromJson(x))
        .toList();
    print('getHosts > hosts.length.toString() :: ' + hosts.length.toString());
    return hosts;
  }

}