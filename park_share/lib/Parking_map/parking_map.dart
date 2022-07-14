import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:park_share/Parking_map/http_helper.dart';
import 'package:park_share/Parking_map/map_builder.dart';
import 'package:park_share/Parking_map/parking_location.dart';
import 'package:park_share/Parking_map/provider_helper.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_share/Bottom_Navigation_Bar/bottom_navigation_bar.dart';

class ParkingMapPage extends StatefulWidget {
  @override
  State<ParkingMapPage> createState() => _ParkingMapPageState();
}

class _ParkingMapPageState extends State<ParkingMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Maps",
          style: GoogleFonts.playfairDisplay(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
      body: MapBuilder(),
      bottomNavigationBar: MyBottomNavigationBar(0),
    );
  }
}
