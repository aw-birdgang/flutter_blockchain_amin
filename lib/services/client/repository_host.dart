import 'package:dio/dio.dart';
import 'package:flutter_blockchain_amin/models/client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../log/custom_logInterceptor.dart';
import 'irepository_host.dart';

class RepositoryClient implements IrepositoryClient {

  @override
  Future registerClient(Client request,) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/auth/register';
    print('registerClient > url :: ' + url);
    print('registerClient > request.toString() :: ' + request.toString());
    String apiKey = dotenv.get('API_KEY');
    print('registerClient > apiKey :: ' + apiKey);
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
        print('registerClient > error.message :: ' + error.message);
        return  handler.next(error);
      }
    ));
    // dio.interceptors.add(CustomLogInterceptor());
    Response response = await dio.post(url, data: request.toMap());
    return Client.fromJson(response.data);
  }

  @override
  Future<List<Client>> getClients() async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/client';
    print('getClients > url :: ' + url);
    Dio dio = Dio();
    Response response = await dio.get(url);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    // CustomLog
    dio.interceptors.add(CustomLogInterceptor());
    print('getClients > response.data :: ' + response.toString());
    List<Client> clients = (response.data as List)
        .map((x) => Client.fromJson(x))
        .toList();
    print('getClients > clients.length.toString() :: ' + clients.length.toString());
    return clients;
  }

}