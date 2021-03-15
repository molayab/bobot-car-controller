import 'dart:async';
import 'dart:isolate';

import 'package:BobotMobileController/models/bobot/bluetooth/bobot_characteristic.dart';
import 'package:BobotMobileController/models/bobot/bobot_serial_context.dart';
import 'package:BobotMobileController/models/bobot/bobot_server_model.dart';
import 'package:BobotMobileController/models/bobot/commands/bobot_command.dart';
import 'package:BobotMobileController/providers/ble_provider.dart';

class BobotProvider implements BobotSerialContext {
  final BLEProvider bleProvider;
  Isolate _heartbeatIsolate;
  ReceivePort _receivePort = ReceivePort();
  BobotCharacteristic _communicationChannel;
  BobotServerModel _bobotServerModel;

  BobotProvider(this.bleProvider);

  void startSearch() {
    bleProvider.run();
  }

  void stopSearch() {
    bleProvider.stop();
  }

  Future<List<BobotServerModel>> getAllDevices() async {
    final devices = await bleProvider.getAllDevices();
    return devices.map((d) => BobotServerModel(d.getDevice())).toList();
  }

  void selectBobot(BobotServerModel bobot) {
    this._bobotServerModel = bobot;
  }

  Future<List<BobotCharacteristic>> getCharacteristics() {
    if (null == _bobotServerModel) {
      throw Exception("Error. Please configure the device first.");
    }
    return _bobotServerModel.discoverCharacteristics();
  }

  void usingCharacteristic(BobotCharacteristic c) {
    this._communicationChannel = c;
  }

  Future connect() {
    if (null == _bobotServerModel) {
      throw Exception("Error. Please configure the device first.");
    }
    if (null == _communicationChannel) {
      throw Exception(
          "Error. Please select a characteristic to use in device.");
    }

    final future = _bobotServerModel.connect();
    future.then((_) => _configure());
    return future;
  }

  void sendCommand(BobotCommand command) {
    command.execute(this);
  }

  void disconnect() {
    if (null == _bobotServerModel) {
      throw Exception("Error. Please configure the device first.");
    }
    _heartbeatIsolate.kill(priority: Isolate.immediate);
    _bobotServerModel.disconnect();
  }

  void _configure() async {
    _heartbeatIsolate = await Isolate.spawn(
        BobotProvider._heartbeatTask,
        BobotServerModelHearbeatConfiguration(
            _receivePort.sendPort, _communicationChannel));
  }

  void _write(List<int> data) {
    if (null == _communicationChannel) {
      throw Exception(
          "Error. Please select a characteristic to use in device.");
    }
    this._communicationChannel.write(data);
  }

  Future<List<int>> _read() {
    if (null == _communicationChannel) {
      throw Exception(
          "Error. Please select a characteristic to use in device.");
    }
    return this._communicationChannel.read();
  }

  static void _heartbeatTask(BobotServerModelHearbeatConfiguration config) {
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      config.sendPort.send(BobotServerModelHearbeat.live);
    });
  }

  @override
  Future<List<int>> read() {
    return _read();
  }

  @override
  void write(List<int> data) {
    _write(data);
  }
}
