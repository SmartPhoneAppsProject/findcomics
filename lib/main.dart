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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Comics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Scan BarCode and QR'),
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
  String name = "";
  String newName = "";

  Future _incrementCounter() async{
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
    String url = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid=dj00aiZpPU43aHIyUkp0U2FpeCZzPWNvbnN1bWVyc2VjcmV0Jng9NWU-&jan_code=${barcodeScanRes}";

    http.get(url).then((response) async {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> hits = data["hits"];
      name = hits[0]["name"];
      newName = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Rename(name: name);
      }));
      setState(() {
        name = newName;
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
            ListView(
              children: <Widget>[
                Card(
                child:ListTile(
                  title: Text(name),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(name)),
                    );
                  },
                ),
                ),
                Card(
                  child:ListTile(
                    title: Text(name),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(name)),
                      );
                    },
                  ),
                ),
                Card(
                  child:ListTile(
                    title: Text(name),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(name)),
                      );
                    },
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.settings_overscan),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}