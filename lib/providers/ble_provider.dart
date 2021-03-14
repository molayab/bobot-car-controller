import 'package:BobotMobileController/models/ble.dart';
import 'package:BobotMobileController/models/device.dart';
import 'package:BobotMobileController/models/dummy_device.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEProvider {
  FlutterBlue _flutterBlue;
  List<BLE> _cachedDevices;

  BLEProvider() {
    this._flutterBlue = FlutterBlue.instance;
  }

  void run() {
    _flutterBlue.startScan(timeout: Duration(seconds: 10));
    _flutterBlue.scanResults.listen((results) {
      _cachedDevices =
          results.map((device) => BLE(device: WrappedDevice(device.device)));
    });
  }

  void stop() {
    _flutterBlue.stopScan();
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
