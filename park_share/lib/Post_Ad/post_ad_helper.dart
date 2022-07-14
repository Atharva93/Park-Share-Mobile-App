//import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FireBaseHelper {
  FireBaseHelper._privateConstructor();
  String QRCodeLink = "";

  static FireBaseHelper fbHelper = FireBaseHelper._privateConstructor();

  //Firebase.initializeApp();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Ads");

  Future<void> uploadImage(File imageFile, String ImageName) async {
    String url;
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference ref = _storage.ref().child("${ImageName}");
    UploadTask uploadTask = ref.putFile(imageFile);
    var dowurl =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    QRCodeLink = dowurl.toString();
  }

  Future<void> postAd(
    String lot,
    String title,
    String note,
    String phoneNumber,
    String rentalType,
    String userID,
    String availableFrom,
    String availableTill,
    String QRImageLink,
    double rate,
    String userBought,
  ) {
    return collectionReference
        .add({
          'ParkingLot': lot,
          'Title': title,
          'UserComments': note,
          'PhoneNumber': phoneNumber,
          'UserPosted': userID,
          'CostForLong': rentalType,
          'Cost': rate,
          'AvailableFrom': availableFrom,
          'AvailableTill': availableTill,
          'Available': true,
          'QRCodeUrl': QRImageLink,
          'UserBought': userBought
        })
        .then((value) => print("Ad posted"))
        .catchError((error) => print("Failed to post ad: $error"));
  }
}

class RentalRateFormatter {
  RentalRateFormatter._privateConstructor();
  static RentalRateFormatter rateFormatter =
      RentalRateFormatter._privateConstructor();

  static String formatRate(String input) {
    String formattedString = input.trim();
    int decimalIndex = input.indexOf('.');
    int inputLength = input.length;

    if (decimalIndex == -1) {
      return input;
    } else if (inputLength == decimalIndex + 1) {
      formattedString = input.substring(0, decimalIndex + 1) + "00";
    } else if (inputLength == decimalIndex + 2) {
      formattedString = input.substring(0, decimalIndex + 2) + "0";
    } else if (inputLength >= decimalIndex + 3) {
      formattedString = input.substring(0, decimalIndex + 3);
    }

    return formattedString;
  }
}

class DateTimeHelper {
  //String _setTime, _setDate;
  //String _hour, _minute, _time;
  //String dateTime;

  DateTimeHelper._privateConstructor();
  static DateTimeHelper dateTimeHelper = DateTimeHelper._privateConstructor();

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  static String formatDate(DateTime rawDate) {
    String formattedDate =
        ""; // want this to be in format of 'December 18, 2021 at 12:00:00:00 PM'
    String stringMonth = "";
    int numericMonth = rawDate.month;

    if (numericMonth == 1) {
      stringMonth = "January";
    } else if (numericMonth == 2) {
      stringMonth = "February";
    } else if (numericMonth == 3) {
      stringMonth = "March";
    } else if (numericMonth == 4) {
      stringMonth = "April";
    } else if (numericMonth == 5) {
      stringMonth = "May";
    } else if (numericMonth == 6) {
      stringMonth = "June";
    } else if (numericMonth == 7) {
      stringMonth = "July";
    } else if (numericMonth == 8) {
      stringMonth = "August";
    } else if (numericMonth == 9) {
      stringMonth = "September";
    } else if (numericMonth == 10) {
      stringMonth = "October";
    } else if (numericMonth == 11) {
      stringMonth = "November";
    } else if (numericMonth == 12) {
      stringMonth = "December";
    }

    formattedDate = stringMonth +
        " " +
        rawDate.day.toString() +
        ", " +
        rawDate.year.toString() +
        " at ";

    return formattedDate;
  }
}
