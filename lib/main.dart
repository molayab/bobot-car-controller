import 'package:BobotMobileController/providers/ble_provider.dart';
import 'package:BobotMobileController/scenes/connection/connection_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bobot Controller',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConnectionView(
        bleProvider: BLEProvider(),
      ),
    );
  }
}
