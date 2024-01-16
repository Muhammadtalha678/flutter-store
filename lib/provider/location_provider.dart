// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:location/location.dart' as Location;
import 'package:newstore/widgets/snackbar.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends ChangeNotifier {
  Location.Location location = Location.Location();
  Location.LocationData? _currentLocation = null;
  Location.LocationData? get currentLocation => _currentLocation;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getLocation(
    context,
  ) async {
    try {
      final response = await http.get(Uri.parse("https://www.google.com/"));
      if (response.statusCode == 200) {
        _currentLocation = await Location.Location().getLocation();
        //  print()
      } else {
        throw Exception();
      }
    } catch (e) {
      _currentLocation = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarError(
            text: "Internet Connection Error",
            // colorBox: Colors.white70,
          ),
        ),
      );
    } finally {
      // print("object");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> searchPostion(String val) async {
    // print(val);
    return val;

    //on camemove
  }

  // change position
  Future<void> changePostion(lat, long) async {
    _currentLocation = Location.LocationData.fromMap({
      'latitude': lat,
      'longitude': long,
    });
    // notifyListeners();

    //on camemove
  }

  //confim location
  var placeName;
  Future<void> confirmPostion(BuildContext context) async {
    // print("object");
    try {
      final response = await http.get(Uri.parse("https://www.google.com/"));
      if (response.statusCode == 200) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentLocation!.latitude!, currentLocation!.longitude!,
            localeIdentifier: "Karachi");
        placeName = placemarks;
        // print(placeName);
        notifyListeners();
      } else {
        throw Exception();
      }
    } catch (e) {
      _currentLocation = null;
      placeName = null;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarError(
            text: "Internet Connection Error",
            // colorBox: Colors.white70,
          ),
        ),
      );
    }
  }
}
