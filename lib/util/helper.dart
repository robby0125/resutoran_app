import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

class Helper {
  static Future<String> getCityFromLatLong(GeoPoint location) async {
    final _coord = Coordinates(location.latitude, location.longitude);
    final _address = await Geocoder.local.findAddressesFromCoordinates(_coord);
    final _cityName = _address.first.addressLine.split(',')[1];
    return _cityName;
  }
}