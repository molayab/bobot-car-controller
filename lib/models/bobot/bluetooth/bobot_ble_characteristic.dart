import 'package:BobotMobileController/models/bobot/bluetooth/bobot_characteristic.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BobotBLECharacteristic extends BobotCharacteristic {
  BluetoothCharacteristic _context;

  BobotBLECharacteristic(this._context);

  void write(List<int> data) {
    _context.write(data);
  }

  Future<List<int>> read() {
    return _context.read();
  }
}
