import 'package:BobotMobileController/interfaces/ui/listable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BLE implements UIListable {
  BLE({this.name});

  final String name;

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline6,
    ); // Text
  }

  @override
  Widget buildTitle(BuildContext context) => null;
}