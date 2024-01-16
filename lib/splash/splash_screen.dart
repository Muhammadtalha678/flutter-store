import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/pages/banner.dart';
import 'package:newstore/pages/network_error.dart';
import 'package:newstore/provider/secure_storage_provider.dart';
import 'package:newstore/secure_storage/secure_storage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AssetImage image;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    image =
        const AssetImage("assets/images/abstract-blur-supermarket_1_50.jpg");
    _checkServer();
    Future.delayed(const Duration(seconds: 3), () async {
      if (await _checkServer()) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BannerPage(),
            ));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NetworkError(),
            ));
      }
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
    _controller.forward();
    _controller.addListener(() {
      if (_controller.isDismissed) {
        _controller.forward();
      }
    });
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      }
    });
  }

  Future<bool> _checkServer() async {
    String splashToken = await SecureStorage().getData('token');
    // print(splashToken.isEmpty);
    if (splashToken.isNotEmpty) {
      context.read<SecureStorageProvider>().security();
    }
    const String response = "http://www.google.com";
    try {
      final res = await http
          .get(Uri.parse(response))
          .timeout(const Duration(seconds: 5));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      }

      return false;
    } on TimeoutException catch (e) {
      print(e);
      return false;
    } on SocketException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(235, 165, 214, 167),
        statusBarBrightness: Brightness.light));
    print("rebuilt");
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  color: Colors.green.shade200.withOpacity(0.8),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            'Jalal Store',
                            style: GoogleFonts.aboreto(
                                fontSize: width(context) * 0.1,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
