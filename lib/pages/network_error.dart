import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/pages/banner.dart';
import 'package:newstore/provider/dashboard_provider.dart';
import 'package:newstore/provider/network_provider.dart';
import 'package:newstore/widgets/auth_button.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<NetworkProvider>(builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(
                  height: height(context) * 0.3,
                ),
                Icon(
                  Icons.signal_wifi_off_outlined,
                  color: Colors.green.shade200,
                  size: width(context) * 0.7,
                ),
                SizedBox(
                  height: height(context) * 0.035,
                ),
                !value.netIsLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.1,
                        ),
                        child: AuthButton(
                          buttonText: "Refresh",
                          fontSize: width(context) * 0.07,
                          padding: width(context) * 0.01,
                          onPressed: () async {
                            context.read<NetworkProvider>().network();
                            if (!await value.network()) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      content: SnackBarError(
                                        text: "Internet Connection Error",
                                      )));
                            } else if (await value.network()) {
                              // print("corrext");
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BannerPage(),
                                  ));
                            }
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                width(context) * 0.1),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: CustomTextWidget(
                            color: Colors.black,
                            text: "Refreshing....",
                            fontSize: width(context) * 0.07,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                SizedBox(
                  height: height(context) * 0.035,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
