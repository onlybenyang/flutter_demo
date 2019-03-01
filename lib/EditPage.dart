import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  var data;
  EditPage(data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Go back! ' + this.data),
        ),
      ),
    );
  }
}
