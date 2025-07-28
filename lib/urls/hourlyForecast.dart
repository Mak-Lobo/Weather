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
  late List hourlyData;
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
        queryParameters: {'apikey': base.apiKey, 'metric': 'true'},
      );
      // mapping response to map
      if (response.statusCode == 200) {
        forecastHourlyList = List<dynamic>.from(response.data);
      }
      print(forecastHourlyList);
      return forecastHourlyList;
    } catch (e) {
      print('Error fetching hourly forecast: $e');
      return null;
    }
  }

  Future getHourlyForecastData() async {
    try {
      await getHourlyForecast();
    } catch (e) {
      print('Error fetching hourly forecast data: $e');
      return null;
    }

    hourlyData = forecastHourlyList.map((forecast) {
      return {
        'date': DateTime.fromMillisecondsSinceEpoch(
          forecast['EpochDateTime'] * 1000,
        ),
        'temperature': forecast['Temperature']['Value'],
        'icon': forecast['WeatherIcon'],
      };
    }).toList();
    // for (var forecast in forecastHourlyList) {
    //   hourlyData.addAll({
    //     'date': DateTime.fromMillisecondsSinceEpoch(
    //       forecast['EpochDateTime'] * 1000,
    //     ),
    //     'temperature': forecast['Temperature']['Value'],
    //     'icon': forecast['WeatherIcon'],
    //   });
    // }

    print('\n$hourlyData');
    return hourlyData;
  }
}
