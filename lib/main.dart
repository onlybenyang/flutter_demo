import 'package:flutter/material.dart';

import 'EditPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "welcome",
      home: Scaffold(
        appBar: AppBar(
          title: Text("home page"),
        ),
        body: MyListView(),
      ),
      theme: ThemeData(
          primaryColor: Colors.amberAccent, platform: TargetPlatform.android),
    );
  }
}

class MyListView extends StatefulWidget {
  final testStr = ["line 1", "line 2", "line 3"];

  @override
  State createState() => MyListViewState();
}

class MyListViewState extends State<MyListView> {
  List<String> dataList;

  @override
  void initState() {
    super.initState();
    dataList = widget.testStr;
  }

  buildMyDraggableTarget(int index, Function removeCallback) {
    return MyDraggableTarget(
      index: index,
      data: dataList[index],
//      removeCallback: removeCallback,
    );
  }

  buildRow(BuildContext context, int index) {
    return Card(
        margin: EdgeInsets.only(bottom: 15.0),
        child: buildMyDraggableTarget(index, removeItem));
  }

  removeItem(int index) {
    dataList.removeAt(index);
    print("remove index= $index");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.testStr.length,
        itemBuilder: (BuildContext context, int index) {
          return buildRow(context, index);
        });
  }
}

class MyDraggableTarget<T> extends StatefulWidget {
  final int index;
  final String data;
//  final Function removeCallback;
  const MyDraggableTarget({Key key, this.index, @required this.data})
      : assert(data != null),
        super(key: key);

  remove(int index) {
    print("remove " + index.toString());
  }

  @override
  State createState() =>
      MyDraggableTargetState(index: this.index, data: this.data);
}

class MyDraggableTargetState extends State<MyDraggableTarget> {
  var index;
  var data;
  var feedback;
  MyDraggableTargetState({@required this.index, @required this.data});
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: data,
      ignoringFeedbackSemantics: false,
      axis: Axis.vertical,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Container(
            height: 80.0,
            child: RawMaterialButton(
              child: Text(data),
              onPressed: () {
                Navigator.push<String>(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new EditPage(data)))
                    .then((String value) {
                  data = value;
                });
              },
            ),
          );
        },
        onAccept: (acceptData) {
          setState(() {
            data = acceptData;
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
          child: Card(
              child: Container(
            height: 80.0,
            child: Text(data),
          ))),
      onDragStarted: () {
        widget.remove(index);
      },
    );
  }
}
