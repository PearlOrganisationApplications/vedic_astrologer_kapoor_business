import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_kapoor_vendor/Network%20Connection/network_check.dart';
import 'package:vedic_kapoor_vendor/Screens/question_screen.dart';
import 'package:vedic_kapoor_vendor/main.dart';

import '../Repo/model/api_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.connectedornot, required String title})
      : super(key: key);
  var connectedornot;

  @override
  State<StatefulWidget> createState() {
    return HomePageOffline();
  }
}

class HomePageOffline extends State<HomePage> {
  late Future<DataModel?> getDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<NetworkStatus>(
        initialData: widget.connectedornot,
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child: NetworkCheck(
          onlineScreen: const QuestionScreen(),
          // const WebViewApp(
          //   title: 'Vedic Kapoor',
          // ),
          offlineScreen: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/On Data.png",
                              // fit: BoxFit.contain,
                              filterQuality: FilterQuality.medium,
                              height: MediaQuery.of(context).size.height * 5.7,
                              width: MediaQuery.of(context).size.width * 5.7,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      ///********************** Refresh Button *******************///
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //             MaterialStateProperty.all(Colors.red)),
                      //     onPressed: UiUpdate,
                      //     child: const Text("Retry"),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 55.0),
                        child: Center(
                          child: Text(
                            "Please! Check Your Internet Connection.",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///*** Creating Network Status Service***//
class NetworkStatusService {
  ///*** Creating Controller For Network Status***///
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }
  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    if (status == ConnectivityResult.wifi) {
      return NetworkStatus.online;
    } else if (status == ConnectivityResult.mobile) {
      return NetworkStatus.online;
    } else if (status == ConnectivityResult.none) {
      return NetworkStatus.offline;
    }
    return NetworkStatus.offline;
  }
}
