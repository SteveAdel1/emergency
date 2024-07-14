import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {

  StreamSubscription? locationSubscription;
  var location = Location();
  CameraPosition currentCameraPosition = CameraPosition(
    target: LatLng(30.04442, 31.235712),
    zoom: 14.4746,
  );
  Set<Marker> markers = {
    Marker(markerId: MarkerId('1'), position: LatLng(30.04442, 31.235712))
  };
  GoogleMapController? mapController;

  changeSettings() {
    location.changeSettings(interval: 4000, distanceFilter: 1);
  }

  getCurrentLocation() async {
    var permissionGranted = await hasePermissionGranted();
    var locationService = await locationEnabled();

    if (permissionGranted && locationService) {
      var locationData = await location.getLocation();
      changeUserLocationOnMaps(locationData);
      print("latitude: ${locationData.latitude}");
      print(" longitude : ${locationData.longitude}");
      print("accuracy: ${locationData.accuracy}");
    }
  }

  hasePermissionGranted() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }

  locationEnabled() async {
    var locationService = await location.serviceEnabled();
    if (!locationService) {
      location.requestService();
    }
    return locationService;
  }

  printLocation(LocationData locationData) async {
    print("latitude: ${locationData.latitude}");
    print(" longitude : ${locationData.longitude}");
    print("accuracy: ${locationData.accuracy}");
    print("speed: ${locationData.speed}");
    print("satelliteNumber: ${locationData.satelliteNumber}");
  }

  closeTracking() async {
    locationSubscription!.cancel();
  }

  locationTracking() {
    locationSubscription = location.onLocationChanged.listen((locationData) {
      print("location change");
      printLocation(locationData);
    });
  }

  changeUserLocationOnMaps(LocationData locationData) async{
    markers.clear();
    markers.add(
        Marker(
        markerId: MarkerId('2'),
        position: LatLng(locationData.latitude!, locationData.longitude!)));
    mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(locationData.latitude!, locationData.longitude!)));
  }
}
