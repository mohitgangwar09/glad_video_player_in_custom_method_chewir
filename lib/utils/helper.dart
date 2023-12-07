import 'dart:async';
import 'dart:io';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glad/utils/extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'  as http;
import 'package:share_plus/share_plus.dart';

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

// calculateAge(DateTime birthDate) {
//   DateTime currentDate = DateTime.now();
//   int age = currentDate.year - birthDate.year;
//   int month1 = currentDate.month;
//   int month2 = birthDate.month;
//   if (month2 > month1) {
//     age--;
//   } else if (month1 == month2) {
//     int day1 = currentDate.day;
//     int day2 = birthDate.day;
//     if (day2 > day1) {
//       age--;
//     }
//   }
//   return age;
// }
String getAge(DateTime date) {
  DateDuration duration = AgeCalculator.age(date);
  if(duration.years > 0) {
    return '${duration.years} years';
  } else if(duration.months > 0) {
    return '${duration.months} months';
  } else if(duration.days > 0) {
    return '${duration.days} days';
  } else if(duration.days == 0) {
    return '1 day';
  } else{
    return '';
  }
}

String getPostAge(DateTime date) {
  DateDuration duration = AgeCalculator.dateDifference(fromDate: date, toDate: DateTime.now());
  if(duration.years > 0) {
    return DateFormat('dd MMM, yyyy').format(date);
  } else if(duration.months > 0) {
    return DateFormat('dd MMM, yyyy').format(date);
  } else if(duration.days > 7) {
    return DateFormat('dd MMM, yyyy').format(date);
  } else if(duration.days == 1) {
    return '${duration.days} day ago';
  } else if(duration.days > 0) {
    return '${duration.days} days ago';
  } else if(DateTime.now().difference(date).inHours == 1) {
    return '${DateTime.now().difference(date).inHours} hour ago';
  } else if(DateTime.now().difference(date).inHours > 1) {
    return '${DateTime.now().difference(date).inHours} hours ago';
  } else if(DateTime.now().difference(date).inMinutes > 10) {
    return '${DateTime.now().difference(date).inMinutes} mins ago';
  } else{
    return 'just now';
  }
}

bool checkDateMonth(int year,int month){
  final now = DateTime.now();
  final expirationDate = DateTime(year, month);
  final bool isExpired = expirationDate.isBefore(now);
  return isExpired;
}

bool checkDate(DateTime dateTime){
  final now = DateTime.now();
  final expirationDate = DateTime(dateTime.year, dateTime.month);
  final bool isExpired = expirationDate.isBefore(now);
  return isExpired;
}

Future sharePost(String image, String caption, String name) async {
  var response = await http.get(Uri.parse(image));
  await Share.shareXFiles([XFile.fromData(response.bodyBytes, mimeType: 'image/png')], text: caption, subject: 'GLAD community post by $name');
}