import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_share/Account_Management/account_details.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:park_share/Account_Management/login.dart';
import 'package:park_share/Account_Management/profile.dart';
import 'package:park_share/Parking_map/parking_map.dart';
import 'package:park_share/Post_Ad/post_ad_main.dart';
import 'package:park_share/User_ViewPages/view_bought_qrcodes.dart';
import 'package:provider/src/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: Text("PARK IT",
            style: GoogleFonts.playfairDisplay(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
            )),
      ),
      body: Container(
        child: DashboardWidget(
          profile: context.watch<AccountHandler>().getProfile!,
        ),
        decoration: new BoxDecoration(color: Colors.teal.withOpacity(0.1)),
      ),
    );
  }
}

class DashboardWidget extends StatefulWidget {
  final Profile? profile;
  const DashboardWidget({Key? key, this.profile}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int _selectedIndex = 0;
  String space = "          ";
  String userName = "User";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(85.0, 60.0, 85.0, 10.0),
      children: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: ListTile(
                title: Text(" Welcome " + widget.profile?.getFirstName() + "!",
                    style: GoogleFonts.playfairDisplay(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    )),
                subtitle: Text("   Please select one of the following options:",
                    style: GoogleFonts.playfairDisplay(
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                      color: Colors.black,
                    )))),
        Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text("Search for parking",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.black,
                )),
            onTap: () {
              _selectedIndex = 0;
              _onItemTapped(_selectedIndex);
            },
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(
              Icons.view_quilt,
              color: Colors.grey,
            ),
            title: Text("My ParkIT",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.black,
                )),
            onTap: () {
              _selectedIndex = 1;
              _onItemTapped(_selectedIndex);
            },
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              color: Colors.amber,
            ),
            title: Text("Post Ad",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.black,
                )),
            onTap: () {
              _selectedIndex = 2;
              _onItemTapped(_selectedIndex);
            },
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            title: Text("Edit Profile",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.black,
                )),
            onTap: () {
              _selectedIndex = 3;
              _onItemTapped(_selectedIndex);
            },
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            title: Text("Logout",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.black,
                )),
            onTap: () {
              popup();
              _selectedIndex = 4;
              _onItemTapped(_selectedIndex);
            },
          ),
        ),
      ],
    );
  }

  Future<String?> popup() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Logout?'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParkingMapPage(),
          ),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewQrCodes(),
          ),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostAdMainPage(),
          ),
        );
      }
      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountDetailsPage(profile: widget.profile),
          ),
        );
      }
    });
  }
}
