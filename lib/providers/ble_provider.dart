import 'package:BobotMobileController/models/ble.dart';
import 'package:BobotMobileController/models/dummy_device.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEProvider {
  FlutterBlue _flutterBlue;

  BLEProvider() {
    this._flutterBlue = FlutterBlue.instance;
  }

  void run() {

  }

  void stop() {
    
  }

  List<BLE> getAllDevices() {
    return [
      BLE(device: DummyDevice()),
      BLE(device: DummyDevice()),
    ];
  }

  Future tryToConnect(BLE ble) {
    return ble.getDevice().connect();
  }
}