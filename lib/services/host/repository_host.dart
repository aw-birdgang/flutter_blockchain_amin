import 'package:dio/dio.dart';
import 'package:flutter_blockchain_amin/models/host.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../log/custom_logInterceptor.dart';
import 'irepository_host.dart';

class RepositoryHost implements IrepositoryHost {

  @override
  Future registerHost(Host request,) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/auth/auth/register';
    print('registerHost > url :: ' + url);
    print('registerHost > request.toString() :: ' + request.toString());
    String apiKey = dotenv.get('API_KEY');
    print('registerHost > apiKey :: ' + apiKey);
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
    return Host.fromJson(response.data);
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