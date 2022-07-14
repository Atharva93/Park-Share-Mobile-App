import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';

//handles data transfer for user account details with firestore
class AccountHandler with ChangeNotifier {
  AccountHandler._privateConstructor();
  Profile? _profile;
  Profile? get getProfile {
    return _profile;
  }

  set setProfile(Profile? profile) {
    _profile = profile;
    notifyListeners();
  }

  static AccountHandler accountHandler = AccountHandler._privateConstructor();

  final users = FirebaseFirestore.instance.collection("User");

  Future<void> addUser(String fname, String lname, String email, String sid,
      String phoneNumber, String password) {
    return users
        .add({
          'Email': email,
          'FirstName': fname,
          'LastName': lname,
          'Password': password,
          'PhoneNumber': phoneNumber,
          'StudentID': sid,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String fname, String lname, String email, String sid,
      String phoneNumber, String password) {
    return users
        .where('StudentID', isEqualTo: sid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference
            .update({
              'Email': email,
              'FirstName': fname,
              'LastName': lname,
              'Password': password,
              'PhoneNumber': phoneNumber,
              'StudentID': sid,
            })
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      });
    });
  }

  Future<Profile> getUser(String email) {
    return users.where('Email', isEqualTo: email).get().then((event) {
      Map<String, dynamic> documentData = event.docs.single.data();
      return Profile(
          documentData["FirstName"],
          documentData["LastName"],
          documentData["Email"],
          documentData["StudentID"],
          documentData["PhoneNumber"],
          documentData["Password"]);
    }).catchError((error) => print("Failed get user: $error"));
  }

  Future<bool> loginCheck(String email, String password) async {
    bool check = false;
    await users.where('Email', isEqualTo: email).get().then((event) {
      Map<String, dynamic> documentData = event.docs.single.data();
      if (documentData["Password"] == password) {
        check = true;
      }
    }).catchError((error) => print("Failed to authenticate: $error"));
    return check;
  }

  Future<bool> hasAccount(String email, String sid) async {
    bool checkEmail = false;
    bool checkSid = false;

    await users.where('Email', isEqualTo: email).get().then((event) {
      Map<String, dynamic> documentData = event.docs.single.data();
      if (documentData["Email"] == email) {
        checkEmail = true;
      }
    }).catchError((error) => print("Failed to authenticate: $error"));

    await users.where('StudentID', isEqualTo: sid).get().then((event) {
      Map<String, dynamic> documentData = event.docs.single.data();
      if (documentData["StudentID"] == email) {
        checkSid = true;
      }
    }).catchError((error) => print("Failed to authenticate: $error"));

    return checkEmail || checkSid;
  }
}
