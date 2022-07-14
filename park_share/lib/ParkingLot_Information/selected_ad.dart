import 'package:flutter/material.dart';

// Basic class used to store the selected Ad's information
class AdSelected {
  bool Available;
  String DocumentID;
  String AvaiableFrom;
  String AvaiableTill;
  String Cost;
  String CostForLong;
  String ParkingLot;
  String PhoneNumber;
  String QRCodeURL;
  String Title;
  String UserComments;
  String UserPosted;
  AdSelected(
      //Passing all content as a constructor
      this.DocumentID,
      this.Available,
      this.AvaiableFrom,
      this.AvaiableTill,
      this.Cost,
      this.CostForLong,
      this.ParkingLot,
      this.PhoneNumber,
      this.QRCodeURL,
      this.Title,
      this.UserComments,
      this.UserPosted);
}
