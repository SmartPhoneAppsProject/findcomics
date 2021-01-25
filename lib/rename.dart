import 'package:flutter/material.dart';

class Rename extends StatelessWidget {

  final String name;

  Rename({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('本を追加する'),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}