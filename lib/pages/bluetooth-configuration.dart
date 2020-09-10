import 'dart:async';
import 'dart:math';

import 'package:bluetooth/bluetooth.dart';
import 'package:flutter/material.dart';

class BluetoothConfigurationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BluetoothConfigurationPageState();
}

class _BluetoothConfigurationPageState
    extends State<BluetoothConfigurationPage> {
  Map devices = new Map();
  var scanSubscription;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  _BluetoothConfigurationPageState() {
    // devices["00:11:22:33:44"] = "MIBOX 3";
    // devices["00:11:22:33:77"] = "Another device";

    Timer.periodic(new Duration(seconds: 10), (timer) {
      debugPrint(timer.tick.toString());

      // setState(() {
      //   devices["00:${Random.secure().nextInt(90)}:22:33:77"] =
      //       "Another device";
      // });
    });
  }

  void _back(BuildContext context) {
    Navigator.pop(context);
  }

  void _connect(String key) {
    print("Connecting to ${key}...");
  }

  void _startSearch() {
    print("Start search");

    /// Start scanning
    scanSubscription = flutterBlue
        .scan(timeout: Duration(seconds: 30), scanMode: ScanMode.lowLatency)
        .listen((scanResult) {
      // do something with scan result
      // flutterBlue.connect()
      setState(() {
        devices[scanResult.device.id.id] = scanResult.device.name;
      });
      print('name: ${scanResult.device.id}');
      print('name: ${scanResult.device.name}');
      print('localName: ${scanResult.advertisementData.localName}');
    });
  }

  void _stopSearch() {
    print("Stop search");
    scanSubscription.cancel();
  }

  List<Widget> _buildItems() {
    List list = new List<Widget>();

    devices.forEach((key, value) {
      list.add(
        Card(
          child: ListTile(
            onTap: () => _connect(key),
            title: Text(value),
            subtitle: Text(key),
          ),
        ),
      );
    });

    return list;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth connection"),
        ),
        body: Center(
            child: Column(
          children: [
            Row(children: [
              RaisedButton(
                child: Text("Start search"),
                onPressed: _startSearch,
              ),
              RaisedButton(
                child: Text("Stop"),
                onPressed: _stopSearch,
              ),
            ]),
            Expanded(
              child: ListView(shrinkWrap: true, children: _buildItems()),
            ),
          ],
        )));
    // bottomNavigationBar: BottomNavigationBar(
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       title: Text('refresh'),
    //     ),
    //   ],
    // ),
    // );
  }
}
