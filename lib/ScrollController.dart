import 'package:flutter/material.dart';

class ScrollNotificationTestRoute extends StatefulWidget{
  @override
  _ScrollNotificationTestRoute createState()=>
    new _ScrollNotificationTestRoute();
}

class _ScrollNotificationTestRoute extends State<ScrollNotificationTestRoute>{

  String _progress = "0%";
  @override
  Widget build(BuildContext context){
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notifi){
          double progress = notifi.metrics.pixels / notifi.metrics.maxScrollExtent;
          setState(() {
           _progress = "${(progress*100).toInt()}%"; 
          });
          print("bottomEdge:${notifi.metrics.extentAfter == 0}");
          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
              itemCount: 100,
              itemExtent: 50,
              itemBuilder: (context, index){
                return ListTile(title: Text("$index"));
              },
            ),
            CircleAvatar(
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black38,
            )
          ],
        ),
      ),
    );
  }
}