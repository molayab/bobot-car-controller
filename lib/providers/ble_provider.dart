import 'package:BobotMobileController/models/ble.dart';
import 'package:BobotMobileController/models/wrapped_device.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEProvider {
  FlutterBlue _flutterBlue;
  Future<List<BLE>> _cachedDevices;

  BLEProvider() {
    this._flutterBlue = FlutterBlue.instance;
  }
  
  void run() {
    _flutterBlue.startScan(timeout: Duration(seconds: 10));
    _flutterBlue.scanResults.listen((results) {
      _cachedDevices = Future(() {
        return results.map((device) => BLE(device: WrappedDevice(device.device))).toList();
      });
    });
  }

  void stop() {
    _flutterBlue.stopScan();
  }

  Future<List<BLE>> getAllDevices() {
    return _cachedDevices;
  }

  Future tryToConnect(BLE ble) {
    return ble.getDevice().connect();
  }
}
