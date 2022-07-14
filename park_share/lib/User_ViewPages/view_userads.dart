import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserPostedAds extends StatefulWidget {
  const UserPostedAds({Key? key}) : super(key: key);

  @override
  _UserPostedAdsState createState() => _UserPostedAdsState();
}

class _UserPostedAdsState extends State<UserPostedAds> {
  @override
  Widget build(BuildContext context) {
    String StudentID = context
        .watch<AccountHandler>()
        .getProfile!
        .getSid(); // Gets the student ID of User that is Logged in
    return StreamBuilder(
      stream: getFilteredData(StudentID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading events...'));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext ctx, index) {
              final docData = snapshot.data.docs[index].data();
              return Center(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 110,
                                child: Image.network((docData['QRCodeUrl']))),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Title: ",
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                          Text(
                                            docData['Title'],
                                          )
                                        ]),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("From: ",
                                            style: GoogleFonts.playfairDisplay(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            )),
                                        Text(docData['AvailableFrom'])
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Till: ",
                                            style: GoogleFonts.playfairDisplay(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            )),
                                        Text(docData['AvailableTill'])
                                      ],
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Cost: ",
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                          Text(
                                              "\$\ ${docData['Cost'].toString()} / ${docData['CostForLong']}")
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Parking Lot: ",
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                          Text(docData['ParkingLot'])
                                        ]),
                                    Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text("User Notes: ",
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                          Text(docData['UserComments'])
                                        ])),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Contact Number: ",
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                          Text(docData['PhoneNumber'])
                                        ])
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, bottom: 5.0),
                                child: AvaliableIcon(docData['Available'])),
                            Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: TextButton(
                                    child: Text(
                                      'Delete Ad',
                                    ),
                                    onPressed: () {
                                      deleteID(snapshot.data.docs[index].id,
                                              docData['QRCodeUrl'])
                                          .then((value) => ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text('Ad deleted!'))));
                                    })),
                          ]),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

// Changes the icons based on the ad's status
  Widget AvaliableIcon(bool avalaibleStatus) {
    if (avalaibleStatus == true) {
      return Container(
          width: 50,
          height: 50,
          child: Image.network(
              'https://previews.123rf.com/images/bankrx/bankrx1902/bankrx190200535/118018696-grunge-green-active-word-with-star-icon-round-rubber-seal-stamp-on-white-background.jpg'));
    }
    return Container(
        width: 65,
        height: 65,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/sold-icon-concept-logo-vector-design-207255721.jpg'));
  }

// deletes ad collection based on what is selected
  Future<void> deleteID(String id, String QRCodeUrl) async {
    final ads = FirebaseFirestore.instance.collection('Ads');
    await FirebaseStorage
        .instance // deletes the QRCode image from the firestore storage
        .refFromURL(QRCodeUrl)
        .delete()
        .then((value) => print("QR Code deleted"));
//deletes the record that has the  selected id
    await ads.doc(id).delete().then((value) => print(id + "has been deleted!"));
  }

// Query out data based on filters
  Stream<QuerySnapshot> getFilteredData(String UserID) {
    final ads = FirebaseFirestore.instance.collection('Ads');
    return ads.where('UserBought', isEqualTo: UserID).snapshots();
  }
}
