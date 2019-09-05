import 'package:flutter/material.dart';
import 'package:flutter_sample/CounterRoute.dart';
import 'package:flutter_sample/CustomScrollView.dart';
import 'package:flutter_sample/FromRoute.dart';
import 'package:flutter_sample/ListViewRoute.dart';
import 'package:flutter_sample/ScrollController.dart';
import 'package:flutter_sample/TipRoute.dart';
import 'package:flutter_sample/BaseWidgets.dart';
import 'package:flutter_sample/latex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      // 注册app 命名路由表
      routes: {
        "/": (BuildContext context) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        "new_page": (context) => TipRoute(text: '没有通过路由传参'),
        "new_page2": (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        }
      },
      onGenerateRoute: (RouteSettings setting) {
        /**
         * 在打开命名路由时会可能会被调用，
         * 之所以说可能，是因为当调用Navigator.pushNamed(...)打开命名路由时，
         * 如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；
         * 如果路由表中没有注册，才会调用onGenerateRoute来生成路由。
         * 用处，可做路由鉴权
         */
        return MaterialPageRoute(builder: (context) {
          String routerName = setting.name;
          Map<String, Widget> routerMap = {
            'baseWidgets': BaseWidgets(),
            'latex': Latex(),
            'formRoute': FromRoute(),
            'listViewRoute': ListViewRoute(),
            'customScrollViewTestRoute': CustomScrollViewTestRoute(),
            'scrollNotificationTestRoute': ScrollNotificationTestRoute(),
          };
          return routerMap[routerName] ?? null;
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<_Button> buttons = [
    _Button('基础组件介绍', 'baseWidgets'),
    _Button('输入框和表单', 'formRoute'),
    _Button('滚动组件', 'listViewRoute'),
    _Button('CustomScrollView', 'customScrollViewTestRoute'),
    _Button('滚动监听', 'scrollNotificationTestRoute'),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Flex(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text('计数器路由'),
                      textColor: Colors.blue,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Counter(initCount: 3);
                        }));
                      },
                    ),
                    FlatButton(
                      child: Text('open new route'),
                      textColor: Colors.blue,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return new Scaffold(
                            appBar: new AppBar(
                              title: new Text('新路由'),
                            ),
                            body: Center(
                              child: Text('新路由的内容' * 100),
                            ),
                          );
                        }));
                      },
                    ),
                    RaisedButton(
                      onPressed: () async {
                        // var result = await Navigator.pushNamed(context, 'new_page');
                        var result = await Navigator.of(context)
                            .pushNamed('new_page2', arguments: '通过路由传参进入');

                        print("路由返回值：$result");
                      },
                      child: Text("打开提示页"),
                    ),
                    FlatButton(
                      child: Text('打开路由表中未注册路由'),
                      onPressed: () async {
                        Navigator.pushNamed(context, 'latex');
                      },
                    ),
                    FlatButton(
                      child: Text('打开路由表中注册路由'),
                      onPressed: () async {
                        Navigator.pushNamed(context, 'new_page');
                      },
                    ),
                    Image.asset('assets/images/beach_hdr.jpg', width: 200,),
                    ... this
                        .buttons
                        .map((button) => RaisedButton(
                              child: new Text(button.title),
                              onPressed: () async {
                                Navigator.pushNamed(context, button.router);
                              },
                            ))
                        .toList(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('a'),
        tooltip: 'Increment',
        child: Icon(Icons.face),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _Button {
  String router;
  String title;
  _Button(this.title, this.router);
}