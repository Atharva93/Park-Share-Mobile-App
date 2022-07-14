import 'package:flutter/material.dart';
import 'package:park_share/Dashboard/dashboard.dart';
import 'package:park_share/ParkingLot_Information/adbottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class QRCodePage extends StatefulWidget {
  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String formattedDate =
      DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('QR Code',
              style: GoogleFonts.playfairDisplay(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              )),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("The QR Code can only be used ",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontSize: 19,
                          color: Colors.black,
                        )),
                    Text("ONCE",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.black,
                        ))
                  ]),
              Text("*Please scan it at the Parking Lot",
                  style: GoogleFonts.playfairDisplay(
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Image.network(
                SelectedAd[0].QRCodeURL,
                width: 250.0,
              ),
              Text("Date Created: $formattedDate",
                  style: GoogleFonts.playfairDisplay(
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Available From: ',
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      )),
                  Text(SelectedAd[0].AvaiableFrom,
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Available Till: ',
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      )),
                  Text(SelectedAd[0].AvaiableTill,
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Parking Lot: ',
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      )),
                  Text(SelectedAd[0].ParkingLot,
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Contact #: ',
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      )),
                  Text(SelectedAd[0].PhoneNumber,
                      style: GoogleFonts.playfairDisplay(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Ad Note: ${SelectedAd[0].UserComments}",
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                width: 230,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                    },
                    child: Text("Return To Dashboard",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white,
                        ))),
              ),
            ]));
  }
}
