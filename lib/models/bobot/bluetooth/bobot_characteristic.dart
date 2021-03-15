import 'package:flutter_blue/flutter_blue.dart';
import 'bobot_ble_characteristic.dart';

abstract class BobotCharacteristic {
  void write(List<int> data);
  Future<List<int>> read();

  static BobotCharacteristic makeBLECharacteristic(BluetoothCharacteristic c) {
    return BobotBLECharacteristic(c);
  }
}
