import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_share/Account_Management/account_handler.dart';
import 'package:park_share/Bottom_Navigation_Bar/bottom_navigation_bar.dart';
import 'package:park_share/Dashboard/dashboard.dart';
import 'package:park_share/Post_Ad/post_ad_helper.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification.dart';

String userID = "";

class PostAdMainPage extends StatefulWidget {
  final String pageTitle = "PARK IT";
  @override
  _PostAdMainPageState createState() => _PostAdMainPageState();
}

class _PostAdMainPageState extends State<PostAdMainPage> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    userID = context.watch<AccountHandler>().getProfile!.getSid();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.playfairDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text("POST AD",
              style: GoogleFonts.playfairDisplay(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              )),
        ),
        body: Container(
          child: PostAdWidget(),
          decoration: new BoxDecoration(color: Colors.teal.withOpacity(0.1)),
        ),
        bottomNavigationBar: MyBottomNavigationBar(2),
      ),
    );
  }
}

class Keys {
  static final formkey = GlobalKey();
  static final QRCodeKey = GlobalKey();
}

class PostAdWidget extends StatefulWidget {
  const PostAdWidget({Key? key}) : super(key: key);

  @override
  _PostAdWidgetState createState() => _PostAdWidgetState();
}

class _PostAdWidgetState extends State<PostAdWidget> {
  final GlobalKey<FormState> ad_post_formKey = GlobalKey<FormState>();
  String dropdownValue = "Founders Lot 1";
  String? selectedLot;
  String? selectedRentalType;
  String InputedData = "";
  DateTime selectedDate = DateTime.now();
  String _selectedTime = "";
  String title = "";
  String memo = "";
  String QRCodeUrl = "";

  TextEditingController dateinput1 = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();
  TextEditingController timeinput1 = TextEditingController();
  TextEditingController timeinput2 = TextEditingController();
  TextEditingController rateinput = TextEditingController();
  TextEditingController titleinput = TextEditingController();
  TextEditingController noteinput = TextEditingController();
  TextEditingController phoneinput = TextEditingController();

  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(child: Text("Founders Lot 1"), value: "Founders Lot 1"),
    DropdownMenuItem(child: Text("Founders Lot 2"), value: "Founders Lot 2"),
    DropdownMenuItem(child: Text("Founders Lot 3"), value: "Founders Lot 3"),
    DropdownMenuItem(child: Text("Founders Lot 4"), value: "Founders Lot 4"),
    DropdownMenuItem(child: Text("Founders Lot 5"), value: "Founders Lot 5"),
    DropdownMenuItem(
        child: Text("Commencement Lot"), value: "Commencement Lot"),
    DropdownMenuItem(
        child: Text("Simcoe Village Lot"), value: "Simcoe Village Lot"),
    DropdownMenuItem(child: Text("Mary Street"), value: "Mary Street"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: ad_post_formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              controller: titleinput,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("TITLE"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter the title for your ad',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid text';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: DropdownButtonFormField(
                focusColor: Colors.amber,
                decoration: InputDecoration(
                  label: const Text("LOCATION"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null ? "Select a lot" : null,
                dropdownColor: Colors.white.withOpacity(0.9),
                value: selectedLot,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLot = newValue!;
                  });
                },
                items: menuItems),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              controller: phoneinput,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("PHONE NUMBER"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter your contact number',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || value.length != 10) {
                  return 'Please enter a valid telephone number';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                _selectDate(context, dateinput1);
              },
              controller: dateinput1,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("FROM DATE"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter the date the parking pass is valid from',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid date';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                Future<TimeOfDay?> pickedTime = showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                pickedTime.then((timeOfDay) {
                  setState(() {
                    if (timeOfDay == null) {
                      _selectedTime = "";
                    } else {
                      _selectedTime = timeOfDay.format(context);
                    }
                    timeinput1.text = _selectedTime;
                  });
                });
              },
              controller: timeinput1,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("FROM TIME"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter the time the parking pass starts',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a time';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                _selectDate(context, dateinput2);
              },
              controller: dateinput2,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("TILL DATE"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter the date the parking pass expires',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid date';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                Future<TimeOfDay?> pickedTime = showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                pickedTime.then((timeOfDay) {
                  setState(() {
                    if (timeOfDay == null) {
                      _selectedTime = "";
                    } else {
                      _selectedTime = timeOfDay.format(context);
                    }
                    timeinput2.text = _selectedTime;
                  });
                });
              },
              controller: timeinput2,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("TILL TIME"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter the time the parking pass expires',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a time';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: const Text("Rent by"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) =>
                    value == null ? "Select a rent type" : null,
                dropdownColor: Colors.white.withOpacity(0.9),
                value: selectedRentalType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRentalType = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(child: Text("Daily"), value: "day"),
                  DropdownMenuItem(child: Text("Hourly"), value: "hour"),
                ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              onEditingComplete: () {
                rateinput.text = RentalRateFormatter.formatRate(rateinput.text);
              },
              controller: rateinput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("RENTAL RATE (\$)"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'hourly rate',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a dollar amount';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
            child: TextFormField(
              controller: noteinput,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
                filled: true,
                fillColor: Colors.white,
                label: Text("COMMENTS"),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: 'Enter a brief memo for your ad',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid text';
                }
                return null;
              },
            ),
          ),
          Container(
              child: RepaintBoundary(
                  key: Keys.QRCodeKey,
                  child: QrImage(
                    data: InputedData,
                    version: QrVersions.auto,
                    size: 220,
                    gapless: false,
                  ))),
          Text("QR Code will be updated based on your input"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal)),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (ad_post_formKey.currentState!.validate() &
                    (phoneinput.text.length == 10)) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  setState(() {
                    NotificationApi(context).showNotification();

                    QRCodeToImage(
                        selectedLot.toString() + rateinput.text + userID);

                    FireBaseHelper.fbHelper.postAd(
                        selectedLot.toString(),
                        titleinput.text,
                        noteinput.text,
                        phoneFormating(phoneinput.text),
                        selectedRentalType.toString(),
                        userID,
                        dateinput1.text + " " + timeinput1.text,
                        dateinput2.text + " " + timeinput2.text,
                        FireBaseHelper.fbHelper.QRCodeLink,
                        double.parse(rateinput.text),
                        "");

                    ad_post_formKey.currentState!.reset();
                    _clearForm();
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                } else {
                  // if the form is not filled out correctly display a snackbar to fill out the form correctly
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Make sure to fill out all the fields properly.')),
                  );
                }
              },
              child: Text(
                '            POST AD            ',
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> QRCodeToImage(String ImageName) async {
    try {
      RenderRepaintBoundary boundary = Keys.QRCodeKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      ;
      final bytes = byteData!.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final file = await new File('${directory.path}/shareqr.png').create();
      await file.writeAsBytes(bytes);
      await FireBaseHelper.fbHelper.uploadImage(file, ImageName);
    } catch (e) {
      print(e.toString());
    }
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateTimeHelper.formatDate(selectedDate);
      });
    }
  }

  void _clearForm() {
    dateinput1.clear();
    dateinput2.clear();
    timeinput1.clear();
    timeinput2.clear();
    rateinput.clear();
    titleinput.clear();
    noteinput.clear();
    phoneinput.clear();
  }

  String phoneFormating(String x) {
    return ("(${x.substring(0, 3)})-${x.substring(3, 6)}-${x.substring(
      6,
    )}");
  }
}
