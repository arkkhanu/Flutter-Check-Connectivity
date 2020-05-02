import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<DataConnectionStatus> listener;
  DataConnectionStatus _status;
  String statusString = "male";

  checkInternect() async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          _status = DataConnectionStatus.connected;
          setState(() {
            statusString = _status.toString();
          });
          break;
        case DataConnectionStatus.disconnected:
          _status = DataConnectionStatus.disconnected;
          setState(() {
            statusString = _status.toString();
          });
          break;
        default:
          _status = DataConnectionStatus.disconnected;
      }
    });

    statusString = _status.toString();
    return _status;
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  @override
  void initState() {
    super.initState();
    checkInternect();
  }

  @override
  Widget build(BuildContext context) {
    print("ark: " + _status.toString());
    return Scaffold(
        appBar: AppBar(title: Text("Check Connection")),
        body: Container(
          alignment: Alignment.center,
          child: Text(
            statusString,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ));
  }
}
