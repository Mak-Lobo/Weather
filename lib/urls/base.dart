import 'package:flutter_dotenv/flutter_dotenv.dart';

class Base {
  String? _baseUrl, _apiKey;
  Future baseInit() async {
    _baseUrl = dotenv.env['BaseURL'];
    _apiKey = dotenv.env['API_Key'];
  }

  // constructor
  Base() {
    baseInit();
  }

  String get apiBaseUrl {
    return _baseUrl ?? '';
    
  }

  String get apiKey {
    return _apiKey ?? '';
  }
}
