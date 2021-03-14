import 'package:BobotMobileController/interfaces/ui/listable.dart';
import 'package:BobotMobileController/models/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BLE implements UIListable {
  Device _device;
  Device getDevice() => _device;

  BLE({Device device}) {
    this._device = device;
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(
      _device.getUUID(),
      style: Theme.of(context).textTheme.subtitle1,
    ); // Text
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      _device.getName(),
      style: Theme.of(context).textTheme.headline6,
    );
  }
}