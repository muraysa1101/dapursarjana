//import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

Future<LocationData> getLatestPosition() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
      ;
    }
  }

  return await location.getLocation();
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

// Future<Position> getLatestPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
// }

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  double radEarth = 6.3781 * (pow(10.0, 6.0));
  double phi1 = lat1 * (pi / 180);
  double phi2 = lat2 * (pi / 180);

  double delta1 = (lat2 - lat1) * (pi / 180);
  double delta2 = (lng2 - lng1) * (pi / 180);

  double cal1 = sin(delta1 / 2) * sin(delta1 / 2) +
      (cos(phi1) * cos(phi2) * sin(delta2 / 2) * sin(delta2 / 2));

  double cal2 = 2 * atan2((sqrt(cal1)), (sqrt(1 - cal1)));
  double distance = radEarth * cal2;

  return distance;
}

void showSnackbar(BuildContext context, String info,
    {void Function()? action, String? actionLabel}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(info),
    action: action != null
        ? SnackBarAction(label: actionLabel ?? "Go", onPressed: action)
        : null,
  ));
}
