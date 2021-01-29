import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import './rename.dart';
import './new_page.dart';

void main() {
  runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Comics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Bookshelf'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = ""; // apiからとってきた本のタイトル
  String newName = "";  // 書き換えた本のタイトル
  String empty = "漫画を追加してね";  // 本を追加してないときに表示する文字列
  var nameList = new List.generate(3, (i)=>"漫画を追加してね"); // 表示する漫画のタイトルを格納するリスト

  Future _incrementCounter() async{

    // バーコードをスキャンする
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);

    // janコードから商品を検索
    String url = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid=dj00aiZpPU43aHIyUkp0U2FpeCZzPWNvbnN1bWVyc2VjcmV0Jng9NWU-&jan_code=${barcodeScanRes}";

    http.get(url).then((response) async {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> hits = data["hits"];
      name = hits[0]["name"];

      // 漫画を追加する画面にnameを渡して遷移し、返ってきた値をnewNameに格納する
      newName = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Rename(name: name);
      }));
      setState(() {

        // nameの中身をnewNameに書き換える
        for (int i = 0; i < nameList.length; i++) {
          if (nameList[i] == empty) {
            nameList[i] = newName;
            break;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 漫画を一覧表示するリスト
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Card(
                child:ListTile(
                  title: Text(nameList[0]),  // name(本のタイトル)を表示
                  onTap: (){
                    // リストをタップすると漫画詳細画面にnameを渡して遷移する
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(nameList[0])),
                    );
                  },
                ),
                ),
                Card(
                  child:ListTile(
                    title: Text(nameList[1]),  // name(本のタイトル)を表示
                    onTap: (){
                      // リストをタップすると漫画詳細画面にnameを渡して遷移する
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(nameList[1])),
                      );
                    },
                  ),
                ),
                Card(
                  child:ListTile(
                    title: Text(nameList[2]),  // name(本のタイトル)を表示
                    onTap: (){
                      // リストをタップすると漫画詳細画面にnameを渡して遷移する
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(nameList[2])),
                      );
                    },
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      // カメラを起動するボタン
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.settings_overscan),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}