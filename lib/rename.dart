import 'package:flutter/material.dart';

// 漫画を追加する画面
class Rename extends StatelessWidget {

  TextEditingController _controller = new TextEditingController();
  String name;

  Rename({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _controller.text = name;  // テキストフィールドの初期値をメインからもらった値にする

    return Scaffold(
      appBar: AppBar(
        title: Text('本を追加する'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 本のタイトルを変えるテキストフィールド
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'タイトル',
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              // タイトルを決定して前の画面に戻るボタン
              child: RaisedButton(
                child: Text('決定'),
                // 前の画面にテキストフィールドの文字列を渡して戻る
                onPressed: () => Navigator.of(context).pop(_controller.text),
              ),
            ),
          ]
        ),
      ),
    );
  }
}