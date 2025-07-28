import './../urls/base.dart';
import 'package:dio/dio.dart';

class LocationUrls {
  final String locations = 'locations';
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 7000),
      receiveTimeout: Duration(milliseconds: 7000),
    ),
  );
  final base = Base();

  late String baseUrl;
  late List<dynamic> locationDetailList;
  List? locationListDetail;
  String? locationKey, locationName, countryName, stateName;

  LocationUrls() {
    base.baseInit();
    baseUrl = base.apiBaseUrl;
  }

  Future getLocationSearch() async {
    try {
      final response = await dio.get(
        '$baseUrl/$locations/v1/cities/autocomplete/',
        queryParameters: {'apikey': base.apiKey, 'q': 'Thi'},
      );

      // mapping response to location detail map
      if (response.statusCode == 200) {
        locationDetailList = List<dynamic>.from(response.data);
      }

      // unpacking the map list
      for (var location in locationDetailList) {
        print(
          'Location: ${location['LocalizedName']} \tKey: ${location['Key']}\n\tCountry: ${location['Country']['LocalizedName']} \tState: ${location['AdministrativeArea']['LocalizedName']} \n',
        );
      }

      return locationDetailList;
    } catch (e) {
      print('Error fetching locations: $e');
      return null;
    }
  }
}
