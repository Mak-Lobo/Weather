import 'package:location/location.dart';

class DeviceLocation {
  Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  Map<String, dynamic> geocodeData = {};

  // check if the location service is enabled
  Future<bool> checkLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      // location service is not enabled
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return false;
      }
    }
    return true;
  }

  // granting permission
  Future<bool> checkLocationPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // location permission is denied
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // getting the current location
  Future<Map<String, dynamic>> getLocation() async {
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
      interval: 500,
    );
    _locationData = await location.getLocation();
    geocodeData = {
      'latitude': _locationData!.latitude,
      'longitude': _locationData!.longitude,
    };
    // print('Location: ${_locationData!.latitude}, ${_locationData!.longitude}');
    print(_locationData);
    return geocodeData; // print the location _locationData!;
  }
}
