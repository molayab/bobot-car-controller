abstract class BobotSerialContext {
  void write(List<int> data);
  Future<List<int>> read();
}
