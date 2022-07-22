import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpConfigurationProvider {

  String? getApiKey ({String? defaultValue}) {
    String value = dotenv.get('API_KEY');
    print('getApiKey > value :: ' + value);
    if (value == null) {
      return defaultValue;
    }
    return value;
  }

  String? getUrlForKmsKeyEncrypt () {
    String api = dotenv.get('API_URL');
    String url = '$api/v1/key/keyring/encrypt';
    print('encryptKey > url :: ' + url);
    return url;
  }

}