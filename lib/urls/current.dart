import './base.dart';
import 'package:dio/dio.dart';
import '../locations/location.dart';

class CurrentWeather {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );
  late String _baseUrl;
  dynamic _response;

  final base = Base();
  final _deviceLocation = DeviceLocation();
  String? locationKey;
  Map<String, dynamic>? geocodeData;

  CurrentWeather() {
    base.baseInit();
    _baseUrl = base.apiBaseUrl;
  }

  // getting current locations whether details via geo-coordinates
  Future getCurrentLocationWeather() async {
    geocodeData = await _deviceLocation.getLocation();

    // using geocoordinates to get current location
    try {
      final response = await dio.get(
        '$_baseUrl/locations/v1/cities/geoposition/search',
        queryParameters: {
          'apikey': base.apiKey,
          'q': '${geocodeData!['latitude']},${geocodeData!['longitude']}',
        },
      );
      print('Response: ${response.data.runtimeType}');
      _response = response;
    } catch (e) {
      print('Error fetching current location details: $e');
      return null;
    }

    try {
      // using location details (location key) to get current weather
      if (_response.statusCode == 200) {
        locationKey = _response.data['Key'];
        final localWeather = await dio.get(
          '$_baseUrl/currentconditions/v1/$locationKey',
          queryParameters: {'apikey': base.apiKey},
        );

        if (localWeather.statusCode == 200) {
          // mapping response to map
          List currentWeatherList = List<dynamic>.from(localWeather.data);
          final currentWeatherMap = Map<String, dynamic>.from(
            currentWeatherList[0],
          );
          print('\n\n$currentWeatherMap');
        }
      }
    } catch (e) {
      print('Error fetching current weather: $e');
      return null;
    }
  }
}
