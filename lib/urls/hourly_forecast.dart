import 'package:intl/intl.dart';

import './../urls/base.dart';
import 'package:dio/dio.dart';

class HourlyForecast {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 7000),
      receiveTimeout: Duration(milliseconds: 7000),
    ),
  );

  final base = Base();
  List hourlyData = [];
  late List<dynamic> forecastHourlyList;
  late String baseUrl;

  HourlyForecast() {
    base.baseInit();
    baseUrl = base.apiBaseUrl;
  }

  // hourly forecast
  Future getHourlyForecast() async {
    try {
      final response = await dio.get(
        '$baseUrl/forecasts/v1/hourly/12hour/222997',
        queryParameters: {
          'apikey': base.apiKey,
          'metric': 'true',
          'details': 'true',
        },
      );
      // mapping response to map
      if (response.statusCode == 200) {
        forecastHourlyList = List<dynamic>.from(response.data);
      }
      return forecastHourlyList;
    } catch (e) {
      print('Error fetching hourly forecast: $e');
      return null;
    }
  }

  Future<List<dynamic>> getHourlyForecastData() async {
    try {
      await getHourlyForecast();
    } catch (e) {
      print('Error fetching hourly forecast data: $e');
      return [];
    }

    hourlyData = forecastHourlyList.map((forecast) {
      return {
        'time': DateFormat('E d, h:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(forecast['EpochDateTime'] * 1000),
        ),
        'temperature': forecast['Temperature']['Value'],
        'icon': forecast['WeatherIcon'],
        'iconPhrase': forecast['IconPhrase'],
        'wind': forecast['Wind']['Speed']['Value'],
        'direction': forecast['Wind']['Direction']['Localized'],
        'humidity': forecast['RelativeHumidity'],
        'uv': forecast['UVIndex'],
      };
    }).toList();

    for (var data in hourlyData) {
      print(data);
    }
    return hourlyData;
  }
}
