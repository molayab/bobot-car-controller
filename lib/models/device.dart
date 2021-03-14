enum DeviceState {
  connected,
  connecting,
  disconnected,
  disconnecting,
  error
}

abstract class Device<DeviceService> {
  String getName();
  DeviceState getState();
  String getUUID();

  Future connect();
  Future disconnect();
  Future<List<DeviceService>> discoverServices();
}