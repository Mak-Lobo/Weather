import './../urls/base.dart';
import 'package:dio/dio.dart';

class Forecasts {
  final String forecasts = 'forecasts';
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 3000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  final base = Base();
  late Map<String, dynamic> forecastDailyMap, forecastHourlyMap;
  late String baseUrl;

  Forecasts() {
    base.baseInit();
    baseUrl = base.apiBaseUrl;
  }

  // daily forecast function
  Future getDailyForecast() async {
    try {
      final response = await dio.get(
        '$baseUrl/$forecasts/v1/daily/5day/222997',
        queryParameters: {'apikey': base.apiKey, 'metric': 'true'},
      );

      // mapping response to map
      if (response.statusCode == 200) {
        forecastDailyMap = Map<String, dynamic>.from(response.data);
      }

      // presenting hourly forecast data
      var forecastDate = DateTime.fromMillisecondsSinceEpoch(
        forecastDailyMap['Headline']['EffectiveEpochDate'] * 1000,
      );
      var headlineText = forecastDailyMap['Headline']['Text'];

      print('Effective Date: $forecastDate. Headlin: $headlineText.\n');

      for (var forecast in forecastDailyMap['DailyForecasts']) {
        var forecastDate = DateTime.fromMillisecondsSinceEpoch(
          forecast['EpochDate'] * 1000,
        );
        var forecastTemp = forecast['Temperature']['Maximum']['Value'];

        var forecastIconPhrase = forecast['Day']['IconPhrase'];

        print('Date: $forecastDate');
        print('Temperature: $forecastTemp');
        print('IconPhrase: $forecastIconPhrase\n\n');
      }

      return forecastDailyMap;
    } catch (e) {
      print('Error fetching daily forecast: $e');
      return null;
    }
  }
}
