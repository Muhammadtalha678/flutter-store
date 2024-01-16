import 'package:flutter/material.dart';
import 'package:newstore/widgets/auth_textFields.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:location/location.dart';

class YourWidget extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  // Location l = Location();
  bool? s;

  @override
  Widget build(BuildContext context) {
    // print(status.isDenied == true);
    print("object");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTextField(
            label: "s",
            icon: Icons.abc,
          ),
          ElevatedButton(
              onPressed: () {
                _location();
              },
              child: Text("data"))
          // Other widgets...
        ],
      ),
    );
  }

  Future<void> _location() async {
    final status = await Permission.location.request();
    final locationData = await Permission.location.serviceStatus;
    print(status.name);
    // if (status.isGranted) {
    //   if (locationData.isEnabled) {
    //     s = locationData.isEnabled;
    //     f();
    //     // print(location);
    //   } else {
    //     s = locationData.isDisabled;
    //     print("open Location");
    //   }
    // }
  }

  f() async {
    if (s == true) {
      openAppSettings();
    }
  }
}
