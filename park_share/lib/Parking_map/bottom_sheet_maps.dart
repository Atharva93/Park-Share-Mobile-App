import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_share/ParkingLot_Information/list_view_ads.dart';
import 'package:park_share/Parking_map/http_helper.dart';
import 'package:park_share/Parking_map/map_builder.dart';
import 'package:park_share/Parking_map/provider_helper.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class BottomSheetMap extends StatelessWidget {
  const BottomSheetMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        context
                            .watch<ProviderHelper>()
                            .getCurrentParkingLocation
                            .parkingImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              context
                                  .watch<ProviderHelper>()
                                  .getCurrentParkingLocation
                                  .name,
                              style: GoogleFonts.playfairDisplay(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(200, 40)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange[800]!),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Position position = await _getMyLocation();
                                    context.read<HttpHelper>().setPoly = true;
                                    context.read<HttpHelper>().setSource =
                                        LatLng(position.latitude,
                                            position.longitude);
                                    MapBuilder();
                                  },
                                  child: Text(
                                    "Get Directions",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(200, 40)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal[600]!),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ListOfAvalaibleAds(context
                                                .watch<ProviderHelper>()
                                                .getCurrentParkingLocation
                                                .name),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Browse Parking Lot",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }

  Future<Position> _getMyLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
