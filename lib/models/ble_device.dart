import 'package:BobotMobileController/models/device.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEDevice implements Device {
  final BluetoothDevice context;
  Duration connectionTimeout = Duration(minutes: 2);

  BLEDevice({this.context});

  @override
  Future connect() {
    return context.connect(timeout: connectionTimeout);
  }

  @override
  Future disconnect() {
    return context.disconnect();
  }

  @override
  Future<List<BluetoothService>> discoverServices() {
    return context.discoverServices();
  }

  @override
  String getName() {
    return context.name;
  }

  @override
  DeviceState getState() {
    // TODO: implement getState
    throw UnimplementedError();
  }
}