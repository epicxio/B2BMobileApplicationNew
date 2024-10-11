import 'dart:async';
import 'package:coswan/screens/swipepageview/swipepageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //Timer for splash screen
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const SwipePageView())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            extendBody: true,
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(254, 253, 251, 1),
                  Color.fromRGBO(245, 220, 196, 1),
                ])),
            child: Center(
              child: Image(
                image: const  AssetImage('assets/images/coswanlogo.png'),
                height: 188.h,
                width: 219.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
