import 'package:flutter/material.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:park_share/ParkingLot_Information/adbottom_sheet.dart';
import 'package:park_share/QRCode/QRCode.dart';
import 'package:provider/src/provider.dart';
import 'payment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  final String card;
  Checkout(this.card);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int _selectedCard = 0;
  final ads = FirebaseFirestore.instance.collection('Ads');
  TextEditingController _controllerone = TextEditingController();
  TextEditingController _controllertwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userId = context.watch<AccountHandler>().getProfile!.getSid();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text("Checkout",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ))),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 45,
              ),

              // container holds checkout summary
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                          // title
                          child: Text(
                            "Payment Summary",
                            style: GoogleFonts.playfairDisplay(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Parking lot
                        ListTile(
                          title: Text("Parking Lot: "),
                          subtitle: Text(SelectedAd[0].ParkingLot),
                        ),
                        // from date and time
                        ListTile(
                          title: Text("From"),
                          subtitle: Text(SelectedAd[0].AvaiableFrom),
                        ),
                        // till date and time
                        ListTile(
                            title: Text("To"),
                            subtitle: Text(SelectedAd[0].AvaiableTill)),
                        // divider to separate parking information from payment information
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                          indent: 25,
                          endIndent: 25,
                          height: 0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: ListTile(
                              title: Text("Credit Card"),
                              // prints the last 2 digits of the user's card
                              trailing: Text(
                                  "******${widget.card.substring(16 - 2)}"),
                              subtitle: Text(
                                "You will be charged in two days.",
                              )),
                        ),
                        ListTile(
                            title: Text("Total"),
                            trailing: Text("\$${SelectedAd[0].Cost}"),
                            subtitle: Text("Including tax.")),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 5, 10),
                    width: 150,
                    height: 55,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back",
                            style: GoogleFonts.playfairDisplay(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.white,
                            ))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 15, 0, 10),
                    width: 150,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: () {
                          //  updates the ad to be unavailable,
                          //  and labels the user's id as the buyer

                          ads.doc(SelectedAd[0].DocumentID).update({
                            "Available": false,
                            "UserBought": userId
                          }).then((value) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Purchase confirmed')),
                              ));

                          //  navigate to the QR page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRCodePage()),
                          );
                        },
                        child: Text("Confirm",
                            style: GoogleFonts.playfairDisplay(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.white,
                            ))),
                  ),
                ],
              ),
            ],
          ),
          decoration: new BoxDecoration(color: Colors.teal.withOpacity(0.1)),
        ));
  }
}
