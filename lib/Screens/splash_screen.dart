import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vedic_kapoor_vendor/Screens/home_page.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var connectedornot = NetworkStatus.online;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  title: "Vedic Astrologer Kapoor Business",
                  connectedornot: connectedornot)),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 252, 252, 252),
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Image.asset(
                  'assets/logos.png',
                  height: 180,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 220, 0, 2),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Vedic AstrologerKapoor Business",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
