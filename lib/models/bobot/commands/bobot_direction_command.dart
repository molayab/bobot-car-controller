import '../bobot_serial_context.dart';
import 'bobot_command.dart';

class BobotDirectionCommand implements BobotCommand {
  int motor;
  BobotDirection direction;

  BobotDirectionCommand({this.motor, this.direction});

  int getCode() {
    return 2;
  }

  @override
  void execute(BobotSerialContext context) {
    try {
      context.write([getCode(), motor, direction.getCode()]);
    } catch (e) {
      print("Error. Failed to send command ${this.toString()}");
      print(" > Debug: ${e.toString()}");
    }
  }
}

enum BobotDirection { fwd, bck }

extension BobotDirectionBinaryMapper on BobotDirection {
  int getCode() {
    switch (this) {
      case BobotDirection.fwd:
        return 0;
      case BobotDirection.bck:
        return 255;
    }
    return -1;
  }
}
