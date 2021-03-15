import '../bobot_serial_context.dart';

abstract class BobotCommand {
  int getCode();
  void execute(BobotSerialContext context);
}
