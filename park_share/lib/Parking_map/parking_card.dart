import 'package:flutter/material.dart';

class ParkingCard extends StatelessWidget {
  const ParkingCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
    );
  }
}


class Parking{
  String? location;
  DateTime? validFrom;
  DateTime? expiry;
  String? owner;
  double rate = 0.0;

  Parking(this.location, this.validFrom, this.expiry);

}
