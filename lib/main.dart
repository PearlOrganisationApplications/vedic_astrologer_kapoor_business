import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vedic_kapoor_vendor/Repo/getdata.dart';
import 'package:vedic_kapoor_vendor/Screens/webview_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Repo/model/api_model.dart';
import 'Screens/splash_screen.dart';

enum NetworkStatus { online, offline }

Future<void> main() async {
  var connectedornot = NetworkStatus.offline;

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connectedornot = NetworkStatus.online;
    } else {
      connectedornot = NetworkStatus.offline;
    }
  } on SocketException catch (_) {
    connectedornot = NetworkStatus.offline;
  }
  runApp(MyApp(connectedornot: connectedornot));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.connectedornot}) : super(key: key);
  final connectedornot;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black, statusBarBrightness: Brightness.dark));
    return GetMaterialApp(
        // color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: "VedicAstrologerKapoor Business",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen()
        //       AnimatedSplashScreen(
        //     backgroundColor: Colors.white,
        //     duration: 5000,
        //     splashIconSize: 180,
        //     splash: "assets/logos.png",
        //     splashTransition: SplashTransition.fadeTransition,
        //     nextScreen: HomePage(
        //       connectedornot: connectedornot,
        //       title: "VedicAstrologerKapoor Business",
        //     ),
        //   ),
        // );
        );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late Future<DataModel?> getDataModel;

  var iosVersion = "3";
  var androidVersion = "1";
  bool skipupdate = false;
  @override
  void initState() {
    getDataModel = GetData.getInfoData();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<DataModel?>(
        future: getDataModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (int.parse(snapshot.data!.message[0].iosAppVersionCode) >
                int.parse(iosVersion)) {
              if (skipupdate) {}
            }
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: WebViewPage(
                    snapshot.data!.message[0].appLink,
                  ),
                ),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF5F5FFD),
                      rightDotColor: const Color(0xFFF84141),
                      size: 80,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
