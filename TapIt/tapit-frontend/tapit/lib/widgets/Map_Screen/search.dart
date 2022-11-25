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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/search.dart';

import '../../controller/LocationController.dart';
import 'Routing.dart';
import 'SearchResultMetadata.dart';

// A callback to notify the hosting widget.
typedef ShowDialogFunction = void Function(String title, String message);
final LocationController controller = Get.put(LocationController());

class SearchExample {
  final HereMapController _hereMapController;
  final MapCamera _camera;
  MapImage? _poiMapImage;
  final List<MapMarker> _mapMarkerList = [];
  late SearchEngine _searchEngine;
  final ShowDialogFunction _showDialog;
  final LocationController controller = Get.put(LocationController());

  SearchExample(ShowDialogFunction showDialogCallback, HereMapController hereMapController)
      : _showDialog = showDialogCallback,
        _hereMapController = hereMapController,
        _camera = hereMapController.camera {
    double distanceToEarthInMeters = 10000;
    MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
    _camera.lookAtPointWithMeasure(GeoCoordinates(controller.lat.value, controller.long.value), mapMeasureZoom);

    try {
      _searchEngine = SearchEngine();
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    }

    _setTapGestureHandler();
    // _setLongPressGestureHandler();

    // _showDialog("Note", "Long press on map to get the address for that position using reverse geocoding.");
  }

  Future<void> searchHospitalButton() async {
    // Search for "Pizza" and show the results on the map.
    _searching();
  }

  // Future<void> geocodeAnAddressButtonClicked() async {
  //   // Search for the location that belongs to an address and show it on the map.
  //   _geocodeAnAddress();
  // }

  void _searching() {
    String hospitalSearchTerm = "Hospital";
    String policeSearchTerm = "Police";
    String fireSearchTerm = "Fire";
    _searchInViewport(queryString: hospitalSearchTerm, categoryName: hospitalSearchTerm, color: Colors.red);
    _searchInViewport(queryString: policeSearchTerm, categoryName: policeSearchTerm, color: Colors.blue);
    _searchInViewport(queryString: fireSearchTerm, categoryName: fireSearchTerm, color: Colors.orange);
  }



  void _setTapGestureHandler() {
    _hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
      _pickMapMarker(touchPoint);
    });
  }



  void _pickMapMarker(Point2D touchPoint) {
    double radiusInPixel = 2;
    _hereMapController.pickMapItems(touchPoint, radiusInPixel, (pickMapItemsResult) {
      if (pickMapItemsResult == null) {
        // Pick operation failed.
        return;
      }
      List<MapMarker> mapMarkerList = pickMapItemsResult.markers;
      if (mapMarkerList.isEmpty) {
        print("No map markers found.");
        return;
      }

      MapMarker topmostMapMarker = mapMarkerList.first;
      Metadata? metadata = topmostMapMarker.metadata;
      if (metadata != null) {
        CustomMetadataValue? customMetadataValue = metadata.getCustomValue("key_search_result");
        if (customMetadataValue != null) {
          SearchResultMetadata searchResultMetadata = customMetadataValue as SearchResultMetadata;
          String title = searchResultMetadata.searchResult.title;
          String vicinity = searchResultMetadata.searchResult.address.addressText;
          _showDialog("Picked Search Result", "$title. Vicinity: ");
          return;
        }
      }

      double lat = topmostMapMarker.coordinates.latitude;
      double lon = topmostMapMarker.coordinates.longitude;
      _showDialog("Picked Map Marker", "Geographic coordinates: $lat, $lon.");
    });
  }

  Future<void> _searchInViewport({required String queryString, String? categoryName, required Color color}) async {
    _clearMap();

    GeoBox viewportGeoBox = _getMapViewGeoBox();
    TextQueryArea queryArea = TextQueryArea.withBox(viewportGeoBox);
    TextQuery query = TextQuery.withArea(queryString, queryArea);

    SearchOptions searchOptions = SearchOptions.withDefaults();
    searchOptions.languageCode = LanguageCode.enUs;
    searchOptions.maxItems = 1;
    RoutingExample? routingExample = RoutingExample(_showDialog, _hereMapController);

    _searchEngine.searchByText(query, searchOptions, (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        _showDialog("Search", "Error: $searchError");
        return;
      }

      // If error is null, list is guaranteed to be not empty.
      int listLength = list!.length;
      // _showDialog("Search for $queryString", "Results: $listLength. Tap marker to see details.");

      // Add new marker for each search result on map.
      for (Place searchResult in list) {
        Metadata metadata = Metadata();
        metadata.setCustomValue("key_search_result", SearchResultMetadata(searchResult));
        // Note: getGeoCoordinates() may return null only for Suggestions.
        addPoiMapMarker(geoCoordinates: searchResult.geoCoordinates!, metadata: metadata, categoryName: categoryName);
        routingExample.addRoute(
            geoCoordinatesEnd: searchResult.geoCoordinates!,
            geoCoordinatesStart: GeoCoordinates(28.450849311256952, 77.58427290184594),
            color: color);
        // _routingExample.clearMap();
      }
    });
  }


  Future<MapMarker> _addPoiMapMarker({required GeoCoordinates geoCoordinates, String? categoryName}) async {
    // Reuse existing MapImage for new map markers.
    if (_poiMapImage == null) {
      print('$categoryName');
      Uint8List imagePixelData = await _loadFileAsUint8List(fileName: '$categoryName.png');
      _poiMapImage = MapImage.withPixelDataAndImageFormat(imagePixelData, ImageFormat.png);
    }

    MapMarker mapMarker = MapMarker(geoCoordinates, _poiMapImage!);
    _hereMapController.mapScene.addMapMarker(mapMarker);
    _mapMarkerList.add(mapMarker);

    return mapMarker;
  }

  Future<Uint8List> _loadFileAsUint8List({required String fileName}) async {
    // The path refers to the assets directory as specified in pubspec.yaml.
    print('assets/markers/$fileName');
    ByteData fileData = await rootBundle.load('assets/markers/$fileName');
    return Uint8List.view(fileData.buffer);
  }

  Future<void> addPoiMapMarker(
      {required GeoCoordinates geoCoordinates, required Metadata metadata, String? categoryName}) async {
    MapMarker mapMarker = await _addPoiMapMarker(geoCoordinates: geoCoordinates, categoryName: categoryName);
    mapMarker.metadata = metadata;
  }

  // GeoCoordinates _getMapViewCenter() {
  //   return _camera.state.targetCoordinates;
  // }

  GeoBox _getMapViewGeoBox() {
    GeoBox? geoBox = _camera.boundingBox;
    if (geoBox == null) {
      print(
          "GeoBox creation failed, corners are null. This can happen when the map is tilted. Falling back to a fixed box.");
      GeoCoordinates southWestCorner = GeoCoordinates(
          _camera.state.targetCoordinates.latitude - 0.05, _camera.state.targetCoordinates.longitude - 0.05);
      GeoCoordinates northEastCorner = GeoCoordinates(
          _camera.state.targetCoordinates.latitude + 0.05, _camera.state.targetCoordinates.longitude + 0.05);
      geoBox = GeoBox(southWestCorner, northEastCorner);
    }
    return geoBox;
  }

  void _clearMap() {
    for (var mapMarker in _mapMarkerList) {
      _hereMapController.mapScene.removeMapMarker(mapMarker);
    }
    _mapMarkerList.clear();
  }
}
