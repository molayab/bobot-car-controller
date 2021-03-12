import 'package:BobotMobileController/models/ble.dart';
import 'package:BobotMobileController/providers/ble_provider.dart';
import 'package:BobotMobileController/scenes/controller/controller_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionView extends StatefulWidget {
  final BLEProvider bleProvider;

  ConnectionView({this.bleProvider});

  @override
  State<StatefulWidget> createState() {
    return _ConnectionViewState(bleProvider: bleProvider);
  }
}

class _ConnectionViewState extends State<ConnectionView> {
  final BLEProvider bleProvider;
  BuildContext _loadingContext;
  List<BLE> _devices;
  bool _isScanning = false;

  _ConnectionViewState({this.bleProvider}) {
    _devices = bleProvider.getAllDevices();
  }

  void refreshDevices() {
    setState(() {
      this._devices = bleProvider.getAllDevices();      
    });
  }

  void _tryConnectTo({BLE device, BuildContext inContext}) {
    bleProvider.tryToConnect(device).then((_) {
      print("connected ${device.getDevice().getName()}");
      Navigator.pop(_loadingContext);
      Navigator.push(
        inContext,
        MaterialPageRoute(
          builder: (context) => ControllerView()
        )
      );
    });
  }

  Future refresh() {
    return Future.microtask(() {
      refreshDevices();
    });
  }

  void _showLoading(BuildContext context) {
    _loadingContext = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator(),);
    });
  }

  void _toggleScanning() {
    setState(() {
      if (_isScanning) {
        bleProvider.stop();
        _isScanning = false;
      } else {
        bleProvider.run();
        _isScanning = true;
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devices"),
      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(),
        child: ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (context, index) {
            final device = _devices[index];
            return ListTile(
              title: device.buildTitle(context),
              subtitle: device.buildSubtitle(context),
              onTap: (){
                _showLoading(context);
                _tryConnectTo(
                  device: device,
                  inContext: context
                );
              },
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isScanning ? Icons.stop : Icons.search),
        onPressed: () => _toggleScanning(),
      ),
    );
  }
}