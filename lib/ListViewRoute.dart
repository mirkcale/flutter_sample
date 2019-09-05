import 'package:flutter/material.dart';

class ListViewRoute extends StatefulWidget {
  _ListViewRoute createState() => _ListViewRoute();
}

class _ListViewRoute extends State<ListViewRoute> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('listview'),
      ),
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Scrollbar(
                child: ListView.builder(
                    itemExtent: 50.0,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('$index'),
                      );
                    },
                  ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Scrollbar(
                child: Container(
                  height: 200,
                  child: ListView.separated(
                    itemCount: 30,
                    separatorBuilder: (BuildContext context, int index) =>
                        index & 1 == 1
                            ? Divider(
                                color: Colors.black38,
                              )
                            : Divider(
                                color: Colors.cyanAccent,
                              ),
                    itemBuilder: (BuildContext context, int index) {
                      return Text('text: $index');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
