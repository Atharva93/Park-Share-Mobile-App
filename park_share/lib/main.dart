import 'package:flutter/material.dart';
import 'package:park_share/Parking_map/http_helper.dart';
import 'Account_Management/account_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Account_Management/login.dart';
import 'Parking_map/provider_helper.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProviderHelper()),
      ChangeNotifierProvider(create: (_) => AccountHandler.accountHandler),
      ChangeNotifierProvider(create: (_) => HttpHelper())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PARK IT',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
