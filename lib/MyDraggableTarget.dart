import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDraggableTarget<T> extends StatefulWidget {
  final Widget child;
  final Widget feedback;
  final String title;
  const MyDraggableTarget({
    Key key,
    this.title,
    @required this.child,
    @required this.feedback,
  })  : assert(child != null),
        assert(feedback != null),
        super(key: key);

  @override
  State createState() =>
      MyDraggableTargetState(child: this.child, feedback: this.feedback);
}

class MyDraggableTargetState extends State<MyDraggableTarget> {
  var child;
  var feedback;
  MyDraggableTargetState({@required this.child, @required this.feedback});
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        data: child,
        ignoringFeedbackSemantics: false,
        axis: Axis.vertical,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 80.0,
              child: this.child,
            );
          },
          onAccept: (data) {
            print("$data is onaccept");
            setState(() {
              child = data;
            });
          },
          onLeave: (data) {
            print("$data is onLeave");
          },
          onWillAccept: (data) {
            print("$data is onWillAccept");
            return data != null;
          },
        ),
        feedback: Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            child: Card(child: this.feedback)));
  }
}
