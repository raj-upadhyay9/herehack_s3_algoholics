import 'package:get/get.dart';
import 'package:here_sdk/core.dart';

class LocationController extends GetxController {
  final lat = 28.450849311256952.obs;
  final long = 77.58427290184594.obs;

  GeoCoordinates getLocation() {
    return GeoCoordinates(lat.value, long.value);
  }

  void up(double lati, double lang) {
    lat.value = lati;
    long.value = lang;

    update();
  }
  // update();
}
