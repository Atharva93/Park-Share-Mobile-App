import 'package:flutter/material.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:park_share/Bottom_Navigation_Bar/bottom_navigation_bar.dart';
import 'package:provider/src/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'view_userads.dart';

int selectedIndex = -1; // Used for tracking selected QR Code

class ViewQrCodes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              //Tab bar with two tabs, one being the QR Code and other as 'My ads'
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code),
                      SizedBox(width: 8),
                      Text('Purchased Spots'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 8),
                      Text('My Ads'),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.teal,
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 5,
            title: Text("PARK IT",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ))),
        body: TabBarView(
          children: [
            Container(
                child: GridViewBuilder(),
                decoration: new BoxDecoration(
                    color: Colors.teal.withOpacity(
                        0.1))), // Changing the background of the tabs to light teal
            Container(
                child: UserPostedAds(),
                decoration:
                    new BoxDecoration(color: Colors.teal.withOpacity(0.1)))
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(1),
      ),
    );
  }
}

// Using GridView builder display data
class GridViewBuilder extends StatefulWidget {
  const GridViewBuilder({Key? key}) : super(key: key);

  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  @override
  Widget build(BuildContext context) {
    String StudentID = context.watch<AccountHandler>().getProfile!.getSid();
    return StreamBuilder(
      stream: getFilteredData(StudentID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading events...'));
        }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            padding: const EdgeInsets.all(5),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext ctx, index) {
              final docData = snapshot.data.docs[index].data();
              return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PopUpQRCodeScreen(docData['QRCodeUrl']);
                      }));
                    });
                  },
                  child: GridViewInformation(
                    docData['Title'],
                    docData['AvailableFrom'],
                    docData['AvailableTill'],
                    docData['ParkingLot'],
                    docData['PhoneNumber'],
                    docData['QRCodeUrl'],
                    docData['UserComments'],
                    index,
                  ));
            });
      },
    );
  }
}

// For the fullscreen effect when pressed on the QR Code
class PopUpQRCodeScreen extends StatelessWidget {
  String QRCodeLink = "";
  PopUpQRCodeScreen(this.QRCodeLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'QRCode',
            child: Image.network(QRCodeLink),
          ),
        ),
      ),
    );
  }
}

// Returns a snapshop of the filtered dataa
Stream<QuerySnapshot> getFilteredData(String UserID) {
  final ads = FirebaseFirestore.instance.collection('Ads');
  return ads.where('UserBought', isEqualTo: UserID).snapshots();
}

// Takes in GridView information and contruct tabs based on it
class GridViewInformation extends StatelessWidget {
  String AdTitle;
  String avaliableFrom;
  String avaliableTill;
  String ParkingLot;
  String PhoneNumber;
  String QRCodeURL;
  String usercomments;
  int index;
  GridViewInformation(
      this.AdTitle,
      this.avaliableFrom,
      this.avaliableTill,
      this.ParkingLot,
      this.PhoneNumber,
      this.QRCodeURL,
      this.usercomments,
      this.index);
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  child: FittedBox(
                      child: Image.network(QRCodeURL), fit: BoxFit.fill)),
              Text(
                ParkingLot,
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 14),
                    Text(avaliableFrom, style: TextStyle(fontSize: 10))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.timer_off, size: 14),
                    Text(avaliableTill, style: TextStyle(fontSize: 10))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, size: 14),
                    Text(PhoneNumber, style: TextStyle(fontSize: 10))
                  ]),
            ])),
      ),
    );
  }
}
