import './base.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../device_location//location.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class CurrentWeather {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );
  late String _baseUrl;
  dynamic _response;

  final base = getIt<Base>();
  final _deviceLocation = getIt<DeviceLocation>();
  String? locationKey, locationName;
  Map<String, dynamic>? geocodeData;
  late Map<String, dynamic> currentWeatherMap,
      currentWeatherData,
      tempData,
      savedLocationWeatherMap,
      savedLocationWeatherData;

  CurrentWeather() {
    base.baseInit();
    _baseUrl = base.apiBaseUrl;
  }

  // getting current device_location whether details via geo-coordinates
  Future<Map<String, dynamic>?> getCurrentLocationWeather() async {
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
      // print('Response: ${response.data.runtimeType}');
      _response = response;
    } catch (e) {
      print('Error fetching current location details: $e');
      return null;
    }

    try {
      // using location details (location key) to get current weather
      if (_response.statusCode == 200) {
        locationName = _response.data['LocalizedName'];
        locationKey = _response.data['Key'];
        final localWeather = await dio.get(
          '$_baseUrl/currentconditions/v1/$locationKey',
          queryParameters: {'apikey': base.apiKey, 'details': 'true'},
        );

        if (localWeather.statusCode == 200) {
          // mapping response to map
          List currentWeatherList = List<dynamic>.from(localWeather.data);
          currentWeatherMap = Map<String, dynamic>.from(currentWeatherList[0]);
        }

        // formatting local observable time
        DateTime currentTime = DateTime.parse(
          currentWeatherMap['LocalObservationDateTime'],
        );
        String formattedTime = DateFormat.yMMMEd().add_jmz().format(
          currentTime,
        );

        currentWeatherData = {
          'location': locationName,
          'currentTime': formattedTime,
          'weatherText': currentWeatherMap['WeatherText'],
          'weatherIcon': currentWeatherMap['WeatherIcon'],
          'temperature': currentWeatherMap['Temperature']['Metric']['Value'],
          'feelsLike':
              currentWeatherMap['RealFeelTemperature']['Metric']['Value'],
          'humidity': currentWeatherMap['RelativeHumidity'],
          'wind': currentWeatherMap['Wind']['Speed']['Metric']['Value'],
          'pressure': currentWeatherMap['Pressure']['Metric']['Value'],
        };
      }
      // print(currentWeatherData);
      return currentWeatherData;
    } catch (e) {
      print('Error fetching current weather: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getSavedLocationWeather(
    String locationKey,
  ) async {
    try {
      final response = await dio.get(
        '$_baseUrl/currentconditions/v1/$locationKey',
        queryParameters: {'apikey': base.apiKey, 'details': 'true'},
      );
      if (response.statusCode == 200) {
        List savedLocationWeatherList = List<dynamic>.from(response.data);
        savedLocationWeatherMap = Map<String, dynamic>.from(
          savedLocationWeatherList[0],
        );
        // print(savedLocationWeatherMap);
      }
      // formatting local observable time
      DateTime currentTime = DateTime.parse(
        savedLocationWeatherMap['LocalObservationDateTime'],
      );
      String formattedTime = DateFormat.yMMMEd().add_jmz().format(currentTime);
      savedLocationWeatherData = {
        'currentTime': formattedTime,
        'weatherText': savedLocationWeatherMap['WeatherText'],
        'weatherIcon': savedLocationWeatherMap['WeatherIcon'],
        'temperature':
            savedLocationWeatherMap['Temperature']['Metric']['Value'],
        'feelsLike':
            savedLocationWeatherMap['RealFeelTemperature']['Metric']['Value'],
      };
      return savedLocationWeatherData;
    } catch (e) {
      print('Error fetching saved location weather: $e');
      return {};
    }
  }
}
