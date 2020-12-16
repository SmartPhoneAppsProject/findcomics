import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["漫画１","漫画２","漫画３","漫画４",];
    return MaterialApp(
      title: 'Find Comics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Column(
        children: <Widget>[
          // 漫画の情報を表示するリスト
          Container(
            height: 125,
            padding: EdgeInsets.all(4),
            // childrenを指定してリスト表示
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(list [index]);
              },
              itemCount: list.length,
            ),
          ),


            // カメラを起動するボタン
            FlatButton(
              onPressed: () {},
              child: Text('Camera'),
            ),
            // Raw{
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // children: <Widget>[
            //
            //     }
        ]),
      )
    );
  }
}