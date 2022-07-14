import 'package:latlong2/latlong.dart';

class Route {
  List<LatLng> _path;
  List<String> _instructions;
  double _travelTime;

  Route(this._path, this._instructions, this._travelTime);

  String toString() {
    return "Route(${getPath}, ${getInstructions}, ${getTravelTime})";
  }

  List<LatLng> get getPath {
    return _path;
  }

  set setPath(List<LatLng> path) {
    _path = path;
  }

  List<String> get getInstructions {
    return _instructions;
  }

  set setInstructions(List<String> instructions) {
    _instructions = instructions;
  }

  double get getTravelTime {
    return _travelTime;
  }

  set setTravelTime(double time) {
    _travelTime = time;
  }
}
