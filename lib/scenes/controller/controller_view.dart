import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ControllerViewState();
  }
}

class _ControllerViewState extends State<ControllerView> {

  double posx = 0;
  double posy = 0;

  void onTapDown(DragUpdateDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      print("x: ${localOffset.dx} y: ${localOffset.dy}");
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connected!"),
      ),
      body: Center(
        child: Draggable(
          onDragUpdate: (DragUpdateDetails details) => onTapDown(details),
          feedback: Container(
            height: 100,
            width: 100,
            child: Icon(Icons.adjust),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepOrange.withAlpha(64),
            ),
          ),
          child: Container(
            height: 100.0,
            width: 100.0,
            child: Icon(Icons.adjust),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
              border: Border.all(color: Colors.black)
            )
          ),
        ),
      )
    );
  }
}