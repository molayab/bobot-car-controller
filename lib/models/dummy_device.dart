import 'package:BobotMobileController/models/device.dart';
import 'package:flutter/material.dart';

class DummyService {
}

class DummyDevice implements Device {
  String _name = UniqueKey().toString();
  DeviceState _state = DeviceState.disconnected;

  DummyDevice();

  @override
  Future connect() {
    print("Connecting device ${this._name}");
    return Future.delayed(Duration(seconds: 2), () => null);
  }

  @override
  Future disconnect() {
    print("Disconnecting device ${this._name}");
    return Future.delayed(Duration(seconds: 2), () => null);
  }

  @override
  Future<List<DummyService>> discoverServices() {
    return Future.delayed(Duration(seconds: 2), () => [DummyService()]);
  }

  @override
  String getName() {
    return _name;
  }

  @override
  DeviceState getState() {
    return _state;
  }

  @override
  String getUUID() {
    return UniqueKey().toString();
  }
}