import 'package:flutter/material.dart';
import 'package:newstore/auth/confirm_emial.dart';
import 'package:newstore/auth/login.dart';
import 'package:newstore/auth/register.dart';
import 'package:newstore/pages/all_category.dart';
import 'package:newstore/pages/dashboard.dart';
import 'package:newstore/pages/google_map.dart';
import 'package:newstore/pages/product_category.dart';
import 'package:newstore/provider/allData_provider.dart';
import 'package:newstore/provider/dashboard_provider.dart';
import 'package:newstore/provider/location_provider.dart';
import 'package:newstore/provider/login_provider.dart';
import 'package:newstore/provider/network_provider.dart';
import 'package:newstore/provider/register_provider.dart';
import 'package:newstore/provider/secure_storage_provider.dart';
import 'package:newstore/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DashboardProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => NetworkProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SecureStorageProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RegisterProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AllDataProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        searchBarTheme: SearchBarThemeData(
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          elevation: const MaterialStatePropertyAll<double>(0),
          overlayColor:
              const MaterialStatePropertyAll<Color>(Colors.transparent),
          side: const MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: Colors.green),
          ),
          hintStyle: const MaterialStatePropertyAll<TextStyle>(
            TextStyle(color: Colors.green),
          ),
        ),
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/confirmEmail': (context) => ConfirmEmail(),
        '/googleMap': (context) => MapScreen(),
        '/dashboard': (context) => Dashboard(),
        '/allCategories': (context) => AllCategory(),
        '/productByCategory': (context) => ProductByCategory(),
      },
      // home: const SplashScreen(),
    );
  }
}
