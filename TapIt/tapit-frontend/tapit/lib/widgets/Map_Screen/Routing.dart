/*
 * Copyright (C) 2019-2022 HERE Europe B.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:tapit/controller/addPolyLines.dart';

import '../../controller/LocationController.dart';

// A callback to notify the hosting widget.
typedef ShowDialogFunction = void Function(String title, String message);

class RoutingExample {
  final HereMapController _hereMapController;
  List<MapPolyline> mapPolylines = [];
  PolylinesController mapController = Get.put(PolylinesController());
  late RoutingEngine _routingEngine;
  final ShowDialogFunction _showDialog;
  final LocationController controller = Get.put(LocationController());

  RoutingExample(ShowDialogFunction showDialogCallback, HereMapController hereMapController)
      : _showDialog = showDialogCallback,
        _hereMapController = hereMapController {
    double distanceToEarthInMeters = 10000;
    MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);

    _hereMapController.camera
        .lookAtPointWithMeasure(GeoCoordinates(controller.lat.value, controller.long.value), mapMeasureZoom);

    try {
      _routingEngine = RoutingEngine();
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
  }

  Future<void> addRoute(
      {required GeoCoordinates geoCoordinatesStart,
      required GeoCoordinates geoCoordinatesEnd,
      required Color color}) async {
    mapController.removePolyline(_hereMapController);
    // print(geoCoordinatesEnd.latitude);
    // print(geoCoordinatesEnd.longitude);
    // print(geoCoordinatesStart.latitude);
    // print(geoCoordinatesStart.longitude);
    var destinationGeoCoordinates = geoCoordinatesEnd;
    var startGeoCoordinates = geoCoordinatesStart;
    // var destinationGeoCoordinates2 = GeoCoordinates(28.651108741908057, 77.16507035776974);
    var startWaypoint = Waypoint.withDefaults(startGeoCoordinates);
    var destinationWaypoint = Waypoint.withDefaults(destinationGeoCoordinates);
    // var startWaypoint2 = Waypoint.withDefaults(startGeoCoordinates);
    // var destinationWaypoint2 = Waypoint.withDefaults(destinationGeoCoordinates2);

    List<Waypoint> waypoints = [startWaypoint, destinationWaypoint];
    // List<Waypoint> waypoints2 = [startWaypoint2, destinationWaypoint2];
    _routingEngine.calculateCarRoute(waypoints, CarOptions.withDefaults(),
        (RoutingError? routingError, List<here.Route>? routeList) {
      if (routingError == null) {
        // When error is null, then the list guaranteed to be not null.
        here.Route route = routeList!.first;
        _showRouteDetails(route);
        _showRouteOnMap(route, color);
        _logRouteSectionDetails(route);
        _logRouteViolations(route);
      } else {
        var error = routingError.toString();
        _showDialog('Error', 'Error while calculating a route: $error');
      }
    });
    print("after calculating route $mapPolylines");
  }

  // A route may contain several warnings, for example, when a certain route option could not be fulfilled.
  // An implementation may decide to reject a route if one or more violations are detected.
  void _logRouteViolations(here.Route route) {
    for (var section in route.sections) {
      for (var notice in section.sectionNotices) {
        print("This route contains the following warning: ${notice.code}");
      }
    }
  }

  // void clearMap() {
  //   print("Polylines = $mapPolylines");
  //   for (var mapPolyline in mapPolylines) {

  //     _hereMapController.mapScene.removeMapPolyline(mapPolyline);
  //   }
  //   mapPolylines.clear();
  // }

  void _logRouteSectionDetails(here.Route route) {
    DateFormat dateFormat = DateFormat().add_Hm();

    for (int i = 0; i < route.sections.length; i++) {
      Section section = route.sections.elementAt(i);

      print("Route Section : ${i + 1}");
      print("Route Section Departure Time : ${dateFormat.format(section.departureLocationTime!.localTime)}");
      print("Route Section Arrival Time : ${dateFormat.format(section.arrivalLocationTime!.localTime)}");
      print("Route Section length : ${section.lengthInMeters} m");
      print("Route Section duration : ${section.duration.inSeconds} s");
    }
  }

  void _showRouteDetails(here.Route route) {
    int estimatedTravelTimeInSeconds = route.duration.inSeconds;
    int lengthInMeters = route.lengthInMeters;

    String routeDetails =
        'Travel Time: ${_formatTime(estimatedTravelTimeInSeconds)}, Length: ${_formatLength(lengthInMeters)}';

    // _showDialog('Route Details', '$routeDetails');
  }

  String _formatTime(int sec) {
    int hours = sec ~/ 3600;
    int minutes = (sec % 3600) ~/ 60;

    return '$hours:$minutes min';
  }

  String _formatLength(int meters) {
    int kilometers = meters ~/ 1000;
    int remainingMeters = meters % 1000;

    return '$kilometers.$remainingMeters km';
  }

  _showRouteOnMap(here.Route route, Color color) {
    // Show route as polyline.
    // _hereMapController.mapScene.removeMapPolyline(_mapPolyline!);
    GeoPolyline routeGeoPolyline = route.geometry;
    double widthInPixels = 10;
    MapPolyline routeMapPolyline = MapPolyline(routeGeoPolyline, widthInPixels, color);
    _hereMapController.mapScene.addMapPolyline(routeMapPolyline);
    mapController.addLineToLine(routeMapPolyline);
  }

  // GeoCoordinates _createRandomGeoCoordinatesInViewport() {
  //   GeoBox? geoBox = _hereMapController.camera.boundingBox;
  //   if (geoBox == null) {
  //     // Happens only when map is not fully covering the viewport.
  //     return GeoCoordinates(52.530932, 13.384915);
  //   }

  //   GeoCoordinates northEast = geoBox.northEastCorner;
  //   GeoCoordinates southWest = geoBox.southWestCorner;

  //   double minLat = southWest.latitude;
  //   double maxLat = northEast.latitude;
  //   double lat = _getRandom(minLat, maxLat);

  //   double minLon = southWest.longitude;
  //   double maxLon = northEast.longitude;
  //   double lon = _getRandom(minLon, maxLon);

  //   return GeoCoordinates(lat, lon);
  // }

  double _getRandom(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }
}
