import 'package:BobotMobileController/models/ble.dart';
import 'package:BobotMobileController/providers/ble_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionView extends StatefulWidget {
  final BLEProvider bleProvider;

  ConnectionView({this.bleProvider});

  @override
  State<StatefulWidget> createState() {
    return _ConnectionViewState(bleProvider: bleProvider);
  }
}

class _ConnectionViewState extends State<ConnectionView> {
  final BLEProvider bleProvider;
  List<BLE> _devices;

  _ConnectionViewState({this.bleProvider}) {
    _devices = bleProvider.getAllDevices();
  }

  void refreshDevices() {
    setState(() {
      this._devices = bleProvider.getAllDevices();      
    });
  }

  void _tryConnectTo(BLE device) {
    print("Calling provider::tryConnect(${device.name})");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devices"),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            title: device.buildTitle(context),
            subtitle: device.buildSubtitle(context),
            onTap: (){ _tryConnectTo(device); },
          );
        }
      ),
    );
  }
}