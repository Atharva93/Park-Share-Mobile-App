import 'package:flutter/material.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:park_share/Parking_map/parking_map.dart';
import 'package:park_share/User_ViewPages/view_userads.dart';
import 'package:provider/src/provider.dart';
import 'adbottom_sheet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_share/Bottom_Navigation_Bar/bottom_navigation_bar.dart';

int selectedIndex = -1; // Track selected list
String ParkingLot = ""; //Track the selected parking lot from previous page

class ListOfAvalaibleAds extends StatelessWidget {
  ListOfAvalaibleAds(String mapSelectParkingLot) {
    // change the parking lot based on the what was selected in the previous page
    ParkingLot = mapSelectParkingLot;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 5,
            title: ScaffoldWidgets()),
        body: Container(
            child: ListViewBuilder(),
            decoration: new BoxDecoration(color: Colors.teal.withOpacity(0.1))),
        bottomNavigationBar: MyBottomNavigationBar(0));
  }
}

// Contains widgets that are made just in the scaffold
class ScaffoldWidgets extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(ParkingLot,
            style: GoogleFonts.playfairDisplay(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
        subtitle: Text(
          "Click on the Ad to get more details",
          style: GoogleFonts.playfairDisplay(
            fontStyle: FontStyle.italic,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        trailing: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ParkingMapPage(),
                    ));
              },
              icon: const Icon(Icons.map),
              color: Colors.orange,
            )));
  }
}

// Used to construct the listview based on the what is in the database
class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    String userStudentNumber =
        context.watch<AccountHandler>().getProfile!.getSid();
    return StreamBuilder(
      stream: getFilteredData(ParkingLot, userStudentNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading events...'));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext ctx, index) {
              final docData = snapshot.data.docs[index].data();
              return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      print(snapshot.data.docs[index].id);
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetApp(snapshot.data.docs[index].id);
                          });
                    });
                  },
                  child: ListViewInformation(
                      docData['Title'],
                      docData['UserPosted'],
                      docData['Cost'].toString(),
                      docData['CostForLong'].toString(),
                      index));
            });
      },
    );
  }
}

// Construct a querysnap shot based on the filters
Stream<QuerySnapshot> getFilteredData(String ParkingLot, String userId) {
  final ads = FirebaseFirestore.instance.collection('Ads');
  return ads // filters the 'Ads' collection over Parking lot and student number
      .where('ParkingLot', isEqualTo: ParkingLot)
      .where('UserPosted', isNotEqualTo: userId)
      .snapshots();
}

// Contains widgets that construct the individual list card
class ListViewInformation extends StatelessWidget {
  String adPostedUser;
  String AdTitle;
  String Cost;
  String CostPerPeriod;
  int index;
  ListViewInformation(this.AdTitle, this.adPostedUser, this.Cost,
      this.CostPerPeriod, this.index);
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: index == selectedIndex ? Colors.white : Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(AdTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black,
                    )),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money,
                          color: Colors.orange,
                          size: 25.0,
                        ),
                        Text("\$\ ${Cost} / ${CostPerPeriod}",
                            style: GoogleFonts.playfairDisplay(
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              color: Colors.black,
                            )),
                      ])),
              Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.orange,
                          size: 25.0,
                        ),
                        Text(
                          adPostedUser,
                          style: GoogleFonts.playfairDisplay(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ])),
            ])),
      ),
    );
  }
}
