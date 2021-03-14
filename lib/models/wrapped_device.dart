import 'package:BobotMobileController/models/device.dart';
import 'package:flutter_blue/flutter_blue.dart';

class WrappedDevice extends Device {
  final BluetoothDevice device;

  WrappedDevice(this.device);

  @override
  Future connect() {
    return device.connect();
  }

  @override
  Future disconnect() {
    return device.disconnect();
  }

  @override
  Future<List<BluetoothService>> discoverServices() {
    return device.discoverServices();
  }

  @override
  String getName() {
    return device.name;
  }

  @override
  DeviceState getState() {
    return DeviceState.error;
  }
}
