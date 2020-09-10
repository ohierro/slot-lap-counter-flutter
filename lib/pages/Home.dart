import 'package:flutter/material.dart';
import 'package:sampleNavigation/pages/bluetooth-configuration.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _open(BuildContext ctx) {
    print("Open");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => BluetoothConfigurationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(
            child: RaisedButton(
                onPressed: () => _open(context), child: Text("Open modal"))));
  }
}
