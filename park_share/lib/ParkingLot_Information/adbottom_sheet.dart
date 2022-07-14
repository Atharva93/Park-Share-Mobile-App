import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_share/Payment/payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'selected_ad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

List<AdSelected> SelectedAd = []; // used to store information of selected ad

class BottomSheetApp extends StatelessWidget {
  String DocumentID;
  BottomSheetApp(this.DocumentID); // recieve selected ad id
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Ads')
            .doc(DocumentID)
            .snapshots(), // Get snapshot data of the just the selected ID
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return Container(
              height: 335,
              child: Column(children: <Widget>[
                Container(
                  height: 80,
                  color: Colors.teal.withOpacity(0.6),
                  child: ListTile(
                      title: Text(
                        userDocument['Title'],
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "Added by: " + userDocument['UserPosted'],
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                      trailing: ElevatedButton.icon(
                          onPressed: () {
                            launch("tel://${userDocument['PhoneNumber']}");
                          },
                          icon: Icon(Icons.call, size: 22.0),
                          label:
                              Text("Call", style: TextStyle(fontSize: 17.0)))),
                ),
                ListTile(
                  title: Text(userDocument['ParkingLot'],
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      )),
                  subtitle: Text("Exxact Address to be placed"),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.blueAccent,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: userDocument['ParkingLot']));
                      Fluttertoast.showToast(
                          msg: "Copied to your clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER);
                    },
                    color: Colors.blueAccent,
                  ),
                ),
                ListTile(
                    title: Text("Ticket Information",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        )),
                    leading: Icon(
                      Icons.info,
                      color: Colors.blueAccent,
                    ),
                    subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("From :" +
                              userDocument['AvailableFrom'].toString()),
                          Text("Till :" +
                              userDocument['AvailableTill'].toString()),
                          Text("User Notes: " + userDocument['UserComments']),
                        ]),
                    trailing: Text(
                        "\$\ ${userDocument['Cost'].toString()} / ${userDocument['CostForLong']}",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ))),
                InkWell(
                    // Detect if user pressed on the list tab
                    onTap: () {
                      SelectedAd
                          .clear(); // clear the list so its doesnt add to it
                      SelectedAd.add(AdSelected(
                          DocumentID,
                          userDocument['Available'],
                          userDocument['AvailableFrom'],
                          userDocument['AvailableTill'],
                          userDocument['Cost'].toString(),
                          userDocument['CostForLong'],
                          userDocument['ParkingLot'],
                          userDocument['PhoneNumber'],
                          userDocument['QRCodeUrl'],
                          userDocument['Title'],
                          userDocument['UserComments'],
                          userDocument['UserPosted']));
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType
                              .fade, // fade effect to the next screen
                          child: Payment(),
                        ),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Container(
                            height: 40,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Purchase",
                                      style: GoogleFonts.playfairDisplay(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: Colors.black,
                                      )),
                                  Icon(Icons.payment, size: 30.0)
                                ]),
                            decoration: BoxDecoration(color: Colors.black12))))
              ]));
        });
  }
}
