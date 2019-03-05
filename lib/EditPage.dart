import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  var data;
  final control = TextEditingController();
  EditPage(data) {
    this.data = data;
    control.text = this.data;
    control.selection = TextSelection(
        baseOffset: this.data.toString().length,
        extentOffset: this.data.toString().length);
  }

  onTextChange(String text) {
    this.data = text;
  }

  Widget buildView(BuildContext context) {
    Widget textFieldView = new Container(
      margin: EdgeInsets.only(top: 16.0),
      child: TextField(
        onChanged: (text) => this.onTextChange(text),
        maxLines: null,
        maxLength: 512,
        autofocus: true,
        controller: control,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );

    Widget submitButton = Center(
        child: RaisedButton(
            child: Text("submit"),
            onPressed: () {
              Navigator.pop(context, this.data);
            }));

    return Column(
      children: <Widget>[textFieldView, submitButton],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: buildView(context),
    );
  }
}
