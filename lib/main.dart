import 'package:flutter/material.dart';
import 'MyDraggableTarget.dart';

void main() => runApp(new MyApp());
final testStr = ["line 1", "line 2", "line 3"];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "welcome",
      home: Scaffold(
        appBar: AppBar(
          title: Text("home page"),
        ),
        body: RadioTextRow(),
      ),
      theme: ThemeData(
          primaryColor: Colors.amberAccent, platform: TargetPlatform.android),
    );
  }
}

class RadioTextRow extends StatefulWidget {
  @override
  State createState() => RadioTextRowState();
}

class RadioTextRowState extends State<RadioTextRow> {
  int _groupValue = 0;
  handleLongPress(BuildContext context, int index) {
    print("longPress");
  }

  buildMyDraggableTarget(int index) {
    return MyDraggableTarget(
      child: Container(
        child: Text(testStr[index]),
      ),
      feedback: Container(
        child: Text(testStr[index]),
      ),
    );
  }

  buildRow(BuildContext context, int index) {
    return Card(
        margin: EdgeInsets.only(bottom: 15.0),
        child: buildMyDraggableTarget(index));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: testStr.length,
        itemBuilder: (BuildContext context, int index) {
          return buildRow(context, index);
        });
  }
}
