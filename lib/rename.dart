import 'package:flutter/material.dart';

class Rename extends StatelessWidget {

  TextEditingController _controller = new TextEditingController();
  String name;

  Rename({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _controller.text = name;

    return Scaffold(
      appBar: AppBar(
        title: Text('本を追加する'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: 'テキストを入力してください',
                labelText: 'タイトル',
              ),
            ),
          ]
        ),
      ),
      // body: Center(
      //   child: Text(name),
      // ),
    );
  }
}