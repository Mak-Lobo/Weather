import './../urls/base.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DailyForecast {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 7000),
      receiveTimeout: Duration(milliseconds: 7000),
    ),
  );

  final base = Base();
  Map<String, dynamic> forecastDailyMap = {};
  Map<String, dynamic> dailyData = {};
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
        queryParameters: {
          'apikey': base.apiKey,
          'metric': 'true',
          'details': 'true',
        },
      );

      // mapping response to map
      if (response.statusCode == 200) {
        forecastDailyMap = Map<String, dynamic>.from(response.data);
      }

      for (var forecast in forecastDailyMap['DailyForecasts']) {
        var forecastDate = DateTime.fromMillisecondsSinceEpoch(
          forecast['EpochDate'] * 1000,
        );
        var forecastTemp = forecast['Temperature']['Maximum']['Value'];

        var forecastIconPhrase = forecast['Day']['IconPhrase'];

        print(
          'Date: $forecastDate \t Temperature: $forecastTemp \t IconPhrase: $forecastIconPhrase\n',
        );
      }

      return forecastDailyMap;
    } catch (e) {
      print('Error fetching daily forecast: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getDailyForecastData() async {
    try {
      await getDailyForecast();
    } catch (e) {
      print('Error fetching daily forecast data: $e');
      return {};
    }

    for (var forecast in forecastDailyMap['DailyForecasts']) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        forecast['EpochDate'] * 1000,
      );
      String dateTimeString = DateFormat.yMMMEd().format(date);

      dailyData[dateTimeString] = {
        'date': dateTimeString,
        'max_temperature': forecast['Temperature']['Maximum']['Value'],
        'min_temperature': forecast['Temperature']['Minimum']['Value'],
        'dayIconPhrase': forecast['Day']['IconPhrase'],
        'nightIconPhrase': forecast['Night']['IconPhrase'],
        'dayIcon': forecast['Day']['Icon'],
        'nightIcon': forecast['Night']['Icon'],
      };
    }

    // dailyData.forEach((date, data) {
    //   print('Date: $date');
    //   print('Max Temperature: ${data['max_temperature']}');
    //   print('Min Temperature: ${data['min_temperature']}');
    //   print('Day Icon Phrase: ${data['dayIconPhrase']}');
    //   print('Night Icon Phrase: ${data['nightIconPhrase']}');
    //   print('Day Icon: ${data['dayIcon']}');
    //   print('Night Icon: ${data['nightIcon']}');
    //   print('\n');
    // });
    print(dailyData);
    return dailyData;
  }
}
