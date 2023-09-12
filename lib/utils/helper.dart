import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glad/utils/extension.dart';
import 'package:image_picker/image_picker.dart';

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

validator(String error) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        error.toString(),
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget launchProgress() {
  return const Center(
      child: CircularProgressIndicator(
    color: Color(0xff18444B),
  ));
}

disposeProgress() {
  Get.back();
}

// image Picker from Camera
Future<String> imgFromCamera() async {
  XFile? image = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 50);
  return image!.path;
}

// image Picker from Gallery
Future<String> imgFromGallery() async {
  XFile? image = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50);
  return image!.path;
}

// video Picker from Gallery
Future<String> videoFromGallery() async {
  XFile? image = await ImagePicker()
      .pickVideo(source: ImageSource.gallery);
  return image!.path;
}

// check Internet Connection
Future<bool> checkInternetConnection() async {
  try {
    var result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (kDebugMode) {
        print('connected');
      }
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    if (kDebugMode) {
      print('not connected');
    }
    return false;
  }
}

Future requestLocationPermission() async {
  await Geolocator.requestPermission();
}

double deviceSize(){
  return screenHeight() < 750 ? screenHeight() * 0.68:screenHeight()>870 ? screenHeight()* 0.52:screenHeight()<770?screenHeight()*0.6:screenHeight()*0.54;
}


double ascadf(){
  return screenHeight()>750?40.0:20;
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

bool checkDate(DateTime dateTime){
  final now = DateTime.now();
  final expirationDate = DateTime(dateTime.year, 10);
  final bool isExpired = expirationDate.isBefore(now);
  return isExpired;
}