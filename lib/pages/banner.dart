import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newstore/auth/login.dart';
import 'package:newstore/constants/constants.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/allData_provider.dart';
import 'package:newstore/provider/dashboard_provider.dart';
import 'package:newstore/provider/location_provider.dart';
import 'package:newstore/provider/login_provider.dart';
import 'package:newstore/provider/secure_storage_provider.dart';
import 'package:newstore/widgets/drawer_tile_widget.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BannerPage extends StatelessWidget {
  const BannerPage({super.key});

  Future<void> _location() async {
    print(await Permission.location.status);
    if (await Permission.location.status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild Banner Page");

    return Scaffold(
      backgroundColor: myDefaultColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          systemOverlayStyle: const SystemUiOverlayStyle(
            // statusBarColor: Color.fromARGB(235, 165, 214, 167),
            statusBarColor: Color.fromARGB(235, 165, 214, 167),
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 0,
          backgroundColor: Colors.green.shade200,
          title: Consumer<LocationProvider>(builder: (context, value, child) {
            return CustomTextWidget(
              text:
                  // value.locationPermission() == true ? "No Loxation Added"
                  "",
            );
          }),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          elevation: 0,
          backgroundColor: myDefaultColor,
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: width(context) * 0.065,
                    horizontal: 20,
                    // vertical: height(context) * 0.036,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        FontAwesomeIcons.cartPlus,
                        size: width(context) * 0.2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FontAwesomeIcons.close,
                          size: width(context) * 0.07,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<SecureStorageProvider>(
                      builder: (context, value, child) {
                    if (value.token.isNotEmpty) {
                      // print("object");
                      return Column(
                        children: [
                          DrawerListTile(
                            iconSize: width(context) * 0.05,
                            textSize: width(context) * 0.04,
                            tileIcon: FontAwesomeIcons.user,
                            tileName: "Profile",
                            tileOnTap: () {},
                          ),
                          DrawerListTile(
                            iconSize: width(context) * 0.05,
                            textSize: width(context) * 0.04,
                            tileIcon: FontAwesomeIcons.circle,
                            tileName: "Orders",
                            tileOnTap: () {},
                          ),
                          DrawerListTile(
                            iconSize: width(context) * 0.05,
                            textSize: width(context) * 0.04,
                            tileIcon: FontAwesomeIcons.locationDot,
                            tileName: "Address",
                            tileOnTap: () {},
                          )
                        ],
                      );
                    } else {
                      print("object");
                      return DrawerListTile(
                        iconSize: width(context) * 0.05,
                        textSize: width(context) * 0.04,
                        tileIcon: FontAwesomeIcons.user,
                        tileName: "Login",
                        tileOnTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // maintainState: false,
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
              Expanded(flex: 0, child: Divider()),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Consumer<SecureStorageProvider>(
                          builder: (context, value, child) {
                        if (value.token.isNotEmpty) {
                          return DrawerListTile(
                            iconSize: width(context) * 0.05,
                            textSize: width(context) * 0.04,
                            tileIcon: FontAwesomeIcons.rightFromBracket,
                            tileName: "Logout",
                            tileOnTap: () async {
                              await context
                                  .read<LoginProvider>()
                                  .logout(context);
                              if (context.read<LoginProvider>().logoutNetwork) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: SnackBarError(
                                          text: "Internet Connection Error",
                                        )));
                              }
                              if (context.read<LoginProvider>().logoutUser) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: SnackBarError(
                                          text: "Logout User Successfully",
                                        )));
                              }
                              if (context.read<LoginProvider>().invalidtoken) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: SnackBarError(
                                          text: "Invalid Token",
                                        )));
                              }
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                      DrawerListTile(
                        iconSize: width(context) * 0.05,
                        textSize: width(context) * 0.04,
                        tileIcon: FontAwesomeIcons.star,
                        tileName: "Rating",
                        tileOnTap: () {},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<DashboardProvider>(
          builder: (context, value, child) {
            if (value.networkError) {
              return SizedBox.shrink();
            }
            if (value.banner.isEmpty) {
              // print("object1");
              if (!value.isLoading) {
                print("object");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<DashboardProvider>().getImages(context);
                });
              }

              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                  strokeWidth: 2,
                ),
              );
            } else {
              return Consumer<AllDataProvider>(
                  builder: (context, allValue, child) {
                if (allValue.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.05,
                      vertical: height(context) * 0.05),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var cate =
                              await context.read<AllDataProvider>().allData();

                          if (cate == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: SnackBarError(
                                  text: "Network Error",
                                ),
                              ),
                            );
                          } else {
                            Navigator.pushNamed(context, '/dashboard');
                          }

                          // Navigator.pushNamed(context, '/dashboard');
                        },
                        child: Container(
                          width: double.infinity,
                          // height: 50,
                          height: height(context) * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(value.banner[0].bannerImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // print(value.banner[0].bannerImage);
                      ),
                      // Center(
                      //   child: ElevatedButton(
                      //       onPressed: () async {
                      //         // print("object");
                      //         // if (await Permission.location.isGranted) {
                      //         try {
                      //           final link =
                      //               await http.get(Uri.parse("https://www.google.com/"));
                      //           if (link.statusCode == 200) {
                      //             Navigator.pushNamed(context, '/googleMap');
                      //           } else {
                      //             throw Exception();
                      //           }
                      //         } catch (e) {
                      //           // ignore: use_build_context_synchronously
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //               duration: Duration(seconds: 1),
                      //               behavior: SnackBarBehavior.floating,
                      //               backgroundColor: Colors.transparent,
                      //               elevation: 0,
                      //               content: SnackBarError(
                      //                 text: "Internet Connection Error",
                      //               ),
                      //             ),
                      //           );
                      //         }

                      //       },
                      //       child: Text("data")),
                      // ),
                    ],
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
