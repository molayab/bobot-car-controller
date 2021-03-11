import 'package:BobotMobileController/models/ble.dart';

class BLEProvider {
  List<BLE> getAllDevices() {
    return [
      BLE(name: "test 1"),
      BLE(name: "test 2"),
    ];
  }

  void connectToDevice() {}
}