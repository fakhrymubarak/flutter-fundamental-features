import 'dart:async';
//
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;

class GeoLocatorController extends GetxController {
  final Rx<GeoLocator> geoLocatorValue =
      GeoLocator(null, null, null, null, null, null, null, null).obs;

  @override
  void onInit() {
    _determinePosition().then((value) {
      geoLocatorValue.value = GeoLocator(
          value.latitude.toString(),
          value.longitude.toString(),
          value.accuracy.toString(),
          value.altitude.toString(),
          value.floor.toString(),
          value.speed.toString(),
          value.speedAccuracy.toString(),
          value.timestamp.toString());
    });
    super.onInit();
  }

  Future<Position> _determinePosition() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    if (_permissionGranted == PermissionStatus.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

class GeoLocator {
  String? latitude;
  String? longitude;
  String? accuracy;
  String? altitude;
  String? floor;
  String? speed;
  String? speedAccuracy;
  String? timestamp;

  GeoLocator(this.latitude, this.longitude, this.accuracy, this.altitude,
      this.floor, this.speed, this.speedAccuracy, this.timestamp);
}
