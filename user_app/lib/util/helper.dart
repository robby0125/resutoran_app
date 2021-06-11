import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Helper {
  static Position userPosition;

  static Future<String> getCityFromLatLong(GeoPoint location) async {
    final _address = await getFullAddressFromLatLong(location);
    final _cityName = _address.split(',')[0];
    return _cityName;
  }

  static Future<String> getFullAddressFromLatLong(GeoPoint location) async {
    final _coord = Coordinates(location.latitude, location.longitude);
    final _res = await Geocoder.local.findAddressesFromCoordinates(_coord);
    final _address = _res.first;
    return '${_address.subAdminArea.trim()}, ${_address.adminArea.trim()}';
  }

  static Future<void> determinePosition() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    _permission = await Geolocator.checkPermission();

    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();

      if (!_serviceEnabled) {
        await Geolocator.openLocationSettings();
      }

      if (_permission == LocationPermission.denied) {
        return Future.error('Izin lokasi tidak diberikan!');
      }
    }

    userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
