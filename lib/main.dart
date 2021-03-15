import 'package:BobotMobileController/providers/ble_provider.dart';
import 'package:BobotMobileController/providers/bobot_client_provider.dart';
import 'package:BobotMobileController/scenes/connection/connection_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bobot Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConnectionView(
        bobotProvider: BobotProvider(new BLEProvider()),
      ),
    );
  }
}
