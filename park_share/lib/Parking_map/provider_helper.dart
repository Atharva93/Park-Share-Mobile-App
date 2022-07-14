import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_share/Parking_map/parking_location.dart';
import 'package:park_share/Parking_map/route.dart' as r;

class ProviderHelper with ChangeNotifier {
  String? _title;
  LatLng? _center;

  ParkingLocation _currentParkingLocation = ParkingLocation(
    "Founders Lot 1",
    "2000 Simcoe St N, Oshawa, ON L1H 7K4, Canada",
    LatLng(43.9452, -78.8951),
    "images/founders1.png",
  );

  r.Route? _route;

  set setCurrentParkingLocation(ParkingLocation parkingLocation) {
    _currentParkingLocation = parkingLocation;
    notifyListeners();
  }

  String? get getTitle {
    return _title;
  }

  set setTiltle(String title) {
    _title = title;
  }

  r.Route? get getRoute {
    return _route;
  }

  set setRoute(r.Route route) {
    _route = route;
    notifyListeners();
  }

  ParkingLocation get getCurrentParkingLocation {
    return _currentParkingLocation;
  }
}
