import 'package:flutter/material.dart';
import 'package:park_share/Account_Management/account_details.dart';
import 'package:park_share/Dashboard/dashboard.dart';
import 'package:park_share/Post_Ad/post_ad_main.dart';
import 'package:park_share/User_ViewPages/view_bought_qrcodes.dart';

int _selectedIndex = 0;

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar(int InputselectedIndex) {
    InputselectedIndex = _selectedIndex;
  }
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // int? _selectedIndex = widget.index;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outlined,
            color: Colors.black54,
          ),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
        });
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
            builder: (context) => AccountDetailsPage(),
          ),
        );
      }
    });
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage(),
      ),
    );
  }
}
