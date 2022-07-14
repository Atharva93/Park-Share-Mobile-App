import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_share/Parking_map/route.dart' as r;
import 'package:provider/src/provider.dart';

class HttpHelper with ChangeNotifier {
  static String urlTemplate =
      "https://api.mapbox.com/styles/v1/matalex/ckwivo04r05uw14uq5qzx5jmo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWF0YWxleCIsImEiOiJja3dpdmVyM2YwMGpnMnVvOHRidWN1czMzIn0.KFhN9dHU__nS1R0xYbS4qg";
  static String acces_token =
      "pk.eyJ1IjoibWF0YWxleCIsImEiOiJja3dpdmVyM2YwMGpnMnVvOHRidWN1czMzIn0.KFhN9dHU__nS1R0xYbS4qg";
  static String id = "mapbox.mapbox-streets-v8";

  bool _poly = false;
  LatLng? _source;
  LatLng? _destination;

  bool get getPoly {
    return _poly;
  }

  set setPoly(bool poly) {
    _poly = poly;
    notifyListeners();
  }

  LatLng? get getSource {
    return _source;
  }

  set setSource(LatLng? source) {
    _source = source;
    notifyListeners();
  }

  LatLng? get getDestination {
    return _destination;
  }

  set setDestination(LatLng? destination) {
    _destination = destination;
    notifyListeners();
  }

  static Future<r.Route> getRoute(lat1, lng1, lat2, lng2) async {
    // To be returned by function
    List<String> instructions = [];
    List<LatLng> path = [];
    double travelTime = 0.0;
    // For http request;
    LatLng latLng1 = LatLng(lat1, lng1);
    LatLng latLng2 = LatLng(lat2, lng2);
    String service = "directions";
    String version = "v5";
    String modeOfTravel = "mapbox/driving";
    String geometries = "geojson";
    String steps = "true";
    final queryParameters = {
      "geometries": geometries,
      "access_token": acces_token,
      "steps": steps,
    };

    var url = Uri.https(
        "api.mapbox.com",
        "/${service}/${version}/${modeOfTravel}/${latLng1.longitude},${latLng1.latitude};${latLng2.longitude},${latLng2.latitude}",
        queryParameters);
    var response = await get(url);
    var data = jsonDecode(response.body);
    List<dynamic> maneuvers = data["routes"].first['legs'].first['steps'];
    List<dynamic> coordinates = data["routes"].first['geometry']['coordinates'];
    for (var item in maneuvers) {
      instructions.add(item['maneuver']['instruction']);
    }
    for (var item in coordinates) {
      path.add(LatLng(
        item[0],
        item[1],
      ));
    }
    travelTime = data["routes"].first['duration'];
    r.Route route = r.Route(path, instructions, travelTime);

    return route;
  }
}
