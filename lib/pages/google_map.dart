import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/location_provider.dart';
import 'package:newstore/widgets/bottom_cart.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final _forkey =GlobalKey();
  TextEditingController searchLocation = TextEditingController();
  GoogleMapController? mapController;
  Location.Location location = Location.Location();
  void initState() {
    super.initState();
    _permission();
  }

  Future<void> _permission() async {
    print(await Permission.location.status);
    if (await Permission.location.isDenied) {
      await Permission.location.request();
      setState(() {});
      // openAppSettings();
    }
    if (await Permission.location.status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.location.isGranted) {
      if (await Permission.location.serviceStatus.isDisabled) {
        await location.requestService();
        setState(() {});
      }
      if (await Permission.location.serviceStatus.isEnabled) {
        context.read<LocationProvider>().getLocation(context);
      }
    }
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("object");
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // appBar: AppBar(
      //   title: Text('Google Map'),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<LocationProvider>(
              builder: (context, value, child) {
                if (value.currentLocation != null) {
                  mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          // target: LatLng(20.5937, 78.9629),
                          target: LatLng(value.currentLocation!.latitude!,
                              value.currentLocation!.longitude!),
                          zoom: 17,
                          bearing: 0),
                    ),
                  );
                  // mapController.animateCamera(cameraUpdate)
                }
                // if (value.currentLocation == null) {
                //   mapController?.animateCamera(
                //     CameraUpdate.newCameraPosition(
                //       CameraPosition(
                //           // target: LatLng(20.5937, 78.9629),
                //           target: LatLng(0, 0),
                //           zoom: 14,
                //           bearing: 90),
                //     ),
                //   );
                //   // mapController.animateCamera(cameraUpdate)
                // }
                return GoogleMap(
                    // mapToolbarEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: true,
                    // myLocationEnabled: true,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: onMapCreated,
                    // trafficEnabled: true,
                    onCameraIdle: () async {
                      double latitude =
                          await mapController!.getVisibleRegion().then((value) {
                        return (value.northeast.latitude +
                                value.southwest.latitude) /
                            2;
                      });
                      double longitude =
                          await mapController!.getVisibleRegion().then((value) {
                        return (value.northeast.longitude +
                                value.southwest.longitude) /
                            2;
                      });
                      // if (await Permission.location.serviceStatus.isEnabled) {
                      context
                          .read<LocationProvider>()
                          .changePostion(latitude, longitude);
                      // }
                    },
                    // cameraTargetBounds: CameraTargetBounds(
                    //   LatLngBounds(
                    //     southwest: LatLng(24.7408, 66.9871),
                    //     northeast: LatLng(25.1447, 67.4166),
                    //   ),
                    // ),
                    markers: {
                      Marker(
                        alpha: 0.1,
                        draggable: true,
                        markerId: MarkerId("value"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: value.currentLocation != null
                            ? LatLng(value.currentLocation!.latitude!,
                                value.currentLocation!.longitude!)
                            : LatLng(0, 0),
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                        target: value.currentLocation != null
                            ? LatLng(value.currentLocation!.latitude!,
                                value.currentLocation!.longitude!)
                            : LatLng(0, 0),
                        zoom: 17)
                    // myLocationButtonEnabled: true,
                    );
              },
            ),
            // TextField(),
            Consumer<LocationProvider>(builder: (context, value, child) {
              return Positioned(
                right: 0,
                left: 0,
                top: height(context) * 0.03,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchBar(
                    onTap: () async {
                      // final ur =
                      //     "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyAzPgVrrdD9hL25uVbFgcTOpFz9xNQHqxQ";
                      // // "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=garden&key=AIzaSyBX6h581Ldfrh8Ahd_TWPdxqWdYXF2v5KM&sensor=true";
                      // final response = await http.get(Uri.parse(ur));
                      // print(response.body);
                      // print("object2");
                    },
                    controller: searchLocation,

                    leading: const Icon(
                      FontAwesomeIcons.locationDot,
                      // size: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.green,
                    ),

                    hintText: value.placeName != null
                        ? "${value.placeName[0].street},${value.placeName[0].subLocality},${value.placeName[0].locality},${value.placeName[0].administrativeArea}"
                        : "Search here",

                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.all(8),
                    ),
                    // constraints: BoxConstraints(),
                  ),
                ),
              );
            }),
            Positioned(
              right: 0,
              left: 0,
              top: height(context) * 0.39,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    // width: 120,
                    child: const CustomTextWidget(
                      text: "We will deliver your order here",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              top: height(context) * 0.43,
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  FontAwesomeIcons.locationDot,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ),
            Consumer<LocationProvider>(
              builder: (context, value, child) {
                // print(value.currentLocation!.latitude);
                // print(value.currentLocation!.longitude);
                if (value.currentLocation != null &&
                    (value.currentLocation!.latitude != 0 &&
                        value.currentLocation!.longitude != 0)) {
                  return Positioned(
                    bottom: height(context) * 0.002,
                    left: 0,
                    right: 0,
                    child: Consumer<LocationProvider>(
                      builder: (context, value, child) {
                        return BottomCart(
                          RowWidget: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                text: "Confirm",
                                fontSize: 16,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          onTap: () async {
                            await context
                                .read<LocationProvider>()
                                .confirmPostion(
                                  context,
                                );
                            if (value.placeName != null) {
                              searchLocation.text =
                                  "${value.placeName[0].street},${value.placeName[0].subLocality},${value.placeName[0].locality},${value.placeName[0].administrativeArea}";
                            }
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: height(context) * 0.10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.green,
                          style: BorderStyle.solid,
                          width: 2,
                        )),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        _permission();

                        // setState(() {});
                      },
                      splashColor: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                      // highlightColor: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.my_location,
                              size: 15,
                              color: Colors.green.shade800,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomTextWidget(
                              text: "Go to the current location",
                              fontSize: 12,
                              color: Colors.green.shade500,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      // floatingActionButton:
    );
  }
}
