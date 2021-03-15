import 'package:BobotMobileController/models/bobot/bobot_server_model.dart';
import 'package:BobotMobileController/providers/bobot_client_provider.dart';
import 'package:BobotMobileController/scenes/controller/controller_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionView extends StatefulWidget {
  final BobotProvider bobotProvider;

  ConnectionView({this.bobotProvider});

  @override
  State<StatefulWidget> createState() {
    return _ConnectionViewState(bobotProvider: bobotProvider);
  }
}

class _ConnectionViewState extends State<ConnectionView> {
  final BobotProvider bobotProvider;
  BuildContext _loadingContext;
  List<BobotServerModel> _devices = [];
  bool _isScanning = true;

  _ConnectionViewState({this.bobotProvider}) {
    bobotProvider.startSearch();
    Future.delayed(Duration(milliseconds: 850)).then((_) => refreshDevices());
  }

  @override
  void dispose() {
    print("Stopping BLE scanning...");
    bobotProvider.stopSearch();
    super.dispose();
  }

  void refreshDevices() async {
    if (!_isScanning) {
      return;
    }
    final devices = await bobotProvider.getAllDevices();
    devices.removeWhere((d) =>
        d.getDevice().getName() == "" || d.getDevice().getName() == null);

    setState(() {
      this._devices = devices;
    });
  }

  void _tryConnectTo({BobotServerModel device, BuildContext inContext}) async {
    try {
      final characteristics = await device.discoverCharacteristics();
      // TODO: Create a dynamic selection of the characteristic.
      final tmp = characteristics.first;
      bobotProvider.usingCharacteristic(tmp);
      bobotProvider.selectBobot(device);
      bobotProvider.connect().then((_) {
        print("connected ${device.getDevice().getName()}");
        Navigator.pop(_loadingContext);
        Navigator.push(inContext,
            MaterialPageRoute(builder: (context) => ControllerView()));
      });
    } catch (e) {
      print("Error. ${e.toString()}");
    }
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
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _toggleScanning() {
    setState(() {
      if (_isScanning) {
        bobotProvider.stopSearch();
        _isScanning = false;
      } else {
        bobotProvider.startSearch();
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
                  onTap: () {
                    _showLoading(context);
                    _tryConnectTo(device: device, inContext: context);
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isScanning ? Icons.stop : Icons.search),
        onPressed: () => _toggleScanning(),
      ),
    );
  }
}
