import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather/urls/location.dart';

final getIt = GetIt.instance;
final locationUrl = getIt<LocationUrls>();

Future<Database> getDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'locations.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE locations (locationKey TEXT PRIMARY KEY, cityName TEXT, adminState TEXT, country TEXT)',
      );
    },
  );
}

// initialization
Future<void> initDatabase() async {
  await getDatabase();
}

Future<void> saveLocation(
  String cityName,
  String adminState,
  String country,
  String locationKey,
) async {
  final db = getIt<Database>();

  // Check if the location already exists
  final List<Map<String, dynamic>> existingLocation = await db.query(
    'locations',
    where: 'locationKey = ?',
    whereArgs: [locationKey],
  );

  if (existingLocation.isNotEmpty) {
    print('Location with key $locationKey already exists.');
    return;
  }

  // Store the location data
  await db.insert('locations', {
    'locationKey': locationKey,
    'cityName': cityName,
    'adminState': adminState,
    'country': country,
  });
  print(
    'Location $cityName, $adminState, $country (Key: $locationKey) saved successfully.',
  );
}

// delete function
Future<void> deleteLocation(String locationKey) async {
  final db = getIt<Database>();
  await db.delete(
    'locations',
    where: 'locationKey = ?',
    whereArgs: [locationKey],
  );
  print('Location with key $locationKey deleted successfully.');
}

// provide saved locations
Future<List<Map<String, dynamic>>> getDatabaseLocations() async {
  final db = getIt<Database>();
  final List<Map<String, dynamic>> locations = await db.query('locations');
  return locations;
}
