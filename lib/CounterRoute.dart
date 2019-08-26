import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  Counter({Key key, this.initCount}) : super(key: key);
  final int initCount;

  @override
  _CounterState createState() => _CounterState(initCount);
}

class _CounterState extends State<Counter> {
  _CounterState(this._count);
  int _count;
  int count = 0;

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("计数器应用"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('初始状态$_count'),
            Text('再次点了$count次')
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
