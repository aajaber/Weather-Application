import 'package:geolocator/geolocator.dart';

class Location {
  double? longitude;
  double? latitude;
  Location({
    longitude,
    latitude,
  });

  Future<void> getCurrentLocationFunction() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      longitude = position.longitude;
      latitude = position.latitude;

      print("long: " + longitude.toString());
      print("lat: " + latitude.toString());
    } catch (e) {
      print(e);
    }
  }
}
