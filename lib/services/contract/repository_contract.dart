import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/balance.dart';
import '../log/custom_logInterceptor.dart';
import 'irepository_contract.dart';

class RepositoryContract implements IrepositoryContract {

  @override
  Future getBalance(symbol, address) async {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/contract/$symbol/balance/$address';
    print('getBalance > url :: ' + url);
    Dio dio = Dio();
    Response response = await dio.get(url);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    dio.interceptors.add(CustomLogInterceptor());
    //print('getBalance > response.data :: ' + response.toString());
    return Balance.fromJson(response.data);
  }

}