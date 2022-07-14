import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:park_share/Parking_map/bottom_sheet_maps.dart';
import 'package:park_share/Parking_map/parking_location.dart';
import 'package:park_share/Parking_map/provider_helper.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_share/Bottom_Navigation_Bar/bottom_navigation_bar.dart';
import 'http_helper.dart';
import 'package:park_share/Parking_map/route.dart' as r;

class MapBuilder extends StatefulWidget {
  @override
  _MapBuilderState createState() => _MapBuilderState();
}

class _MapBuilderState extends State<MapBuilder> {
  String? _selectedParkingName;
  LatLng _center = LatLng(43.9452, -78.8951);
  List<ParkingLocation> _parkingLocations = [];
  List<ParkingLocation> _parkingSuggestions =
      ParkingLocation.generatePredefinedParkingLocations();
  List<ParkingLocation> _parkingSuggestionsFiltered = [];
  FloatingSearchBarController _barController = FloatingSearchBarController();
  MapController _mapController = MapController();
  ScrollController _controller = ScrollController();
  r.Route? route;
  ScrollController scrollController = ScrollController();

  void initState() {
    // TODO: implement initState
    _parkingSuggestionsFiltered = _searchParking(query: "");
  }

  @override
  Widget build(BuildContext context) {
    HttpHelper httpHelper = context.watch<HttpHelper>();
    if (httpHelper.getPoly) {
      return Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: HttpHelper.getRoute(
                context.watch<HttpHelper>().getSource!.latitude,
                context.watch<HttpHelper>().getSource!.longitude,
                context.watch<HttpHelper>().getDestination!.latitude,
                context.watch<HttpHelper>().getDestination!.longitude),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              route = snapshot.data;
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) async {},
                  center: _center,
                  maxZoom: 26.0,
                  zoom: 10.0,
                  minZoom: 8.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: HttpHelper.urlTemplate,
                    additionalOptions: {
                      "accessToken": HttpHelper.acces_token,
                      "id": HttpHelper.id,
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        point: context.watch<HttpHelper>().getSource!,
                        builder: (context) {
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_pin,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                      Marker(
                        point: context.watch<HttpHelper>().getDestination!,
                        builder: (context) {
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_pin,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  PolylineLayerOptions(polylines: [
                    Polyline(
                      strokeWidth: 4,
                      color: Colors.teal,
                      points:
                          List.generate(snapshot.data.getPath.length, (index) {
                        return LatLng(snapshot.data.getPath[index].longitude,
                            snapshot.data.getPath[index].latitude);
                      }),
                    ),
                  ])
                ],
              );
              ;
            },
          ),
          FutureBuilder(
            future: HttpHelper.getRoute(
                context.watch<HttpHelper>().getSource!.latitude,
                context.watch<HttpHelper>().getSource!.longitude,
                context.watch<HttpHelper>().getDestination!.latitude,
                context.watch<HttpHelper>().getDestination!.longitude),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox.expand(child: DraggableScrollableSheet(builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.teal.withOpacity(0.5),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: snapshot.data.getInstructions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(
                        "${index + 1}.${snapshot.data.getInstructions[index]}",
                      ));
                    },
                  ),
                );
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    color: Colors.black,
                    //iconSize: 50,
                    onPressed: () {
                      context.read<HttpHelper>().setPoly = false;
                      Navigator.pop(context);
                    },
                    icon: CircleAvatar(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ],
            ),
          )
        ],
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onTap: (tapPosition, point) async {},
            center: _center,
            maxZoom: 26.0,
            zoom: 16.0,
            minZoom: 12.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: HttpHelper.urlTemplate,
              additionalOptions: {
                "accessToken": HttpHelper.acces_token,
                "id": HttpHelper.id,
              },
            ),
            MarkerLayerOptions(
              markers: List.generate(
                _parkingSuggestions.length,
                (index) {
                  return Marker(
                    point: _parkingSuggestions[index].latLng,
                    builder: (context) {
                      return IconButton(
                          onPressed: () {
                            HttpHelper httpHelper = context.read<HttpHelper>();
                            httpHelper.setDestination =
                                _parkingSuggestions[index].latLng;
                            _mapController.move(
                                _parkingSuggestions[index].latLng, 18);
                            context
                                    .read<ProviderHelper>()
                                    .setCurrentParkingLocation =
                                _parkingSuggestions[index];
                            showModalBottomSheet(
                              constraints: BoxConstraints.expand(height: 220),
                              context: context,
                              builder: (context) {
                                return BottomSheetMap();
                              },
                            );
                          },
                          icon: Icon(
                            Icons.location_pin,
                            color: Colors.orange,
                            size: 25,
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
        FloatingSearchBar(
          transitionDuration: Duration(milliseconds: 500),
          debounceDelay: Duration(milliseconds: 500),
          transitionCurve: Curves.bounceIn,
          transition: CircularFloatingSearchBarTransition(),
          controller: _barController,
          hint: 'Search for Parking',
          scrollPadding: EdgeInsets.only(top: 10, bottom: 30),
          physics: BouncingScrollPhysics(),
          openAxisAlignment: 0.0,
          title: Text(
              context.watch<ProviderHelper>().getTitle ?? 'Enter Parking Name'),
          onQueryChanged: (query) {
            setState(() {
              _parkingSuggestionsFiltered = _searchParking(query: query);
            });
          },
          onSubmitted: (query) {
            if (_parkingSuggestionsFiltered.contains(query)) {}
          },
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: Icon(Icons.place),
                onPressed: () {},
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Wrap(
                children: [
                  Container(
                    constraints: BoxConstraints.loose(Size.fromHeight(225)),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.5),
                      backgroundBlendMode: BlendMode.darken,
                    ),
                    child: ListView.separated(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minLeadingWidth: 10,
                            leading: Icon(
                              Icons.location_pin,
                              color: Colors.white,
                            ),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _parkingSuggestionsFiltered[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              _barController.close();
                              context
                                      .read<ProviderHelper>()
                                      .setCurrentParkingLocation =
                                  _parkingSuggestionsFiltered[index];
                              context.read<ProviderHelper>().setTiltle =
                                  _parkingSuggestions[index].name;
                              _mapController.move(
                                  _parkingSuggestionsFiltered[index].latLng,
                                  18);
                              _selectedParkingName =
                                  _parkingSuggestionsFiltered[index].name;
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              thickness: 2.0,
                            ),
                        itemCount: _parkingSuggestionsFiltered.length),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  List<ParkingLocation> _searchParking({required String query}) {
    if ((query.isEmpty != true) && (query != "")) {
      return _parkingSuggestions
          .where((element) =>
              element.name.contains(RegExp(query, caseSensitive: false)))
          .toList();
    } else {
      return _parkingSuggestions;
    }
  }
}
