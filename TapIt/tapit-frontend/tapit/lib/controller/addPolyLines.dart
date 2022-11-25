import 'package:get/get.dart';
import 'package:here_sdk/mapview.dart';

class PolylinesController extends GetxController {
  RxList mapPolyline = [].obs;

  void addLineToLine(MapPolyline polyline) {
    mapPolyline.add(polyline);
    update();
  }

  void removePolyline(HereMapController mapcontroller) {
    for (var line in mapPolyline) {
      mapcontroller.mapScene.removeMapPolyline(line);
    }
    update();
  }
}
