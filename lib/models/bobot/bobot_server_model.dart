import 'dart:async';
import 'dart:isolate';

import '../ble.dart';
import '../device.dart';
import 'bluetooth/bobot_characteristic.dart';
import 'commands/bobot_command.dart';

class BobotServerModel extends BLE {
  BobotServerModel(Device device) : super(device);

  Future connect() {
    return this.getDevice().connect();
  }

  void disconnect() {
    this.getDevice().disconnect();
  }

  Future<List<BobotCharacteristic>> discoverCharacteristics() {
    Future<List<BobotCharacteristic>> future;
    getDevice().discoverServices().then((services) {
      List<BobotCharacteristic> characteristics = services
          .map((s) => s.characteristics)
          .map((cc) =>
              cc.map((c) => BobotCharacteristic.makeBLECharacteristic(c)));
      future = Future(() {
        return characteristics;
      });
    });
    return future;
  }
}

enum BobotServerModelHearbeat { live, dead }

class BobotServerModelHearbeatConfiguration {
  SendPort sendPort;
  BobotCharacteristic characteristic;
  // maybe it won't work due a lacking of sharing memory on dart.
  BobotServerModelHearbeatConfiguration(this.sendPort, this.characteristic);
}
