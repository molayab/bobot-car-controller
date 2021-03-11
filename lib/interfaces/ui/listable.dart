import 'package:flutter/widgets.dart';

abstract class UIListable {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}