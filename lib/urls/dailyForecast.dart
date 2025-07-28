import './../urls/base.dart';
import 'package:dio/dio.dart';

class DailyForecast {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 3000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  final base = Base();
  late Map<String, dynamic> forecastDailyMap;
  late Map<String, dynamic> dailyData;
  late String baseUrl;

  DailyForecast() {
    base.baseInit();
    baseUrl = base.apiBaseUrl;
  }

  // daily forecast function
  Future getDailyForecast() async {
    try {
      final response = await dio.get(
        '$baseUrl/forecasts/v1/daily/5day/222997',
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

  Future getDailyForecastData() async {
    try {
      await getDailyForecast();
    } catch (e) {
      print('Error fetching daily forecast data: $e');
      return null;
    }

    for (var forecast in forecastDailyMap['DailyForecasts']) {
      dailyData = {
        'date': DateTime.fromMillisecondsSinceEpoch(
          forecast['EpochDate'] * 1000,
        ),
        'max_temperature': forecast['Temperature']['Maximum']['Value'],
        'min_temperature': forecast['Temperature']['Minimum']['Value'],
        'dayIconPhrase': forecast['Day']['IconPhrase'],
        'nightIconPhrase': forecast['Night']['IconPhrase'],
        'dayIcon': forecast['Day']['Icon'],
        'nightIcon': forecast['Night']['Icon'],
      };
    }
    return dailyData;
  }
}
