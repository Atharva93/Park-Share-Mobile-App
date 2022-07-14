import 'package:latlong2/latlong.dart';

class ParkingLocation {
  String name;
  String address;
  LatLng latLng;
  String parkingImage;

  ParkingLocation(this.name, this.address, this.latLng, this.parkingImage);

  @override
  String toString() {
    // TODO: implement toString
    return "Address($address)";
  }

  static List<ParkingLocation> generatePredefinedParkingLocations() {
    return [
      ParkingLocation(
          "Founders Lot 1",
          "2000 Simcoe St N, Oshawa, ON L1H 7K4, Canada",
          LatLng(43.9452, -78.8951),
          "images/founders1.png"),
      ParkingLocation(
          "Founders Lot 2",
          "36 Founders Dr, Oshawa, ON L1G 8C4, Canada",
          LatLng(43.9465, -78.8982),
          "images/founders2.png"),
      ParkingLocation(
          "Founders Lot 3",
          "40 Conlin Rd, Oshawa, ON L1H 7K4, Canada",
          LatLng(43.9480, -78.8989),
          "images/founders3.png"),
      ParkingLocation(
          "Founders Lot 4",
          "Campus Ice Center, 2200 Simcoe St N, Oshawa, ON L1H 7K4, Canada",
          LatLng(43.9499, -78.8979),
          "images/founders4.png"),
      ParkingLocation(
          "Founders Lot 5",
          "Simcoe Southbound @ Northern Dancer, Oshawa, ON L0B, Canada",
          LatLng(43.9519, -78.8989),
          "images/founders5.png"),
      ParkingLocation(
        "Commencement Lot",
        "W4R3+PW Oshawa, ON, Canada",
        LatLng(43.9418, -78.8951),
        "images/commencement.png",
      ),
      ParkingLocation(
          "Simcoe Village Lot",
          "2033 Durham Regional Rd 2, Oshawa, ON L1H 7K4, Canada",
          LatLng(43.9457, -78.8937),
          "images/simcoe.png"),
      ParkingLocation(
          "Mary Street",
          "Bond Westbound @ Mary, Oshawa, ON L1G 0A2, Canada",
          LatLng(43.8991, -78.8607),
          "images/mary.png"),
    ];
  }
}
