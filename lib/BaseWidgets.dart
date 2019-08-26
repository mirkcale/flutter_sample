import 'package:flutter/material.dart';

class BaseWidgets extends StatefulWidget {
  _BaseWidgets createState() => _BaseWidgets();
}

class _BaseWidgets extends State<BaseWidgets> {
  bool _checked = false;
  bool _switchChecked = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('基础组件'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Hello world", textAlign: TextAlign.center),
                Text(
                  "Hello world, I'm mircale" * 10,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Hello world",
                  textScaleFactor: 1.8,
                ),
                Image(
                  image: NetworkImage(
                      "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
                  width: 200.0,
                ),
                Image.asset(
                  'assets/images/beach_hdr.jpg',
                  width: 200,
                ),
                Switch(
                  value: _switchChecked, //当前状态
                  onChanged: (value) {
                    //重新构建页面
                    setState(() {
                      _switchChecked = value;
                    });
                  },
                ),
                Checkbox(
                  value: _checked,
                  activeColor: Colors.red, //选中时的颜色
                  onChanged: (value) {
                    setState(() {
                      _checked = value;
                    });
                  },
                ),
                // 模糊进度条(会执行一个动画)
                Padding(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                //进度条显示50%
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .5,
                  ),
                ),

                // 模糊进度条(会执行一个旋转动画)
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),

                //进度条显示50%，会显示一个半圆
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
