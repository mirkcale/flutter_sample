import 'package:flutter/material.dart';

class FromRoute extends StatefulWidget {
  _FromRoute createState() => _FromRoute();
}

class _FromRoute extends State<FromRoute> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode userPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _unameController.text = 'hello world';
    _unameController.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _unameController.text.length - 1,
    );
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('输入框及表单'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    controller: _unameController,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        prefixIcon: Icon(Icons.person)),
                    focusNode: userNameFocusNode,
                    validator: (v) => v.trim().length > 0 ? null : "用户名不能为空",
                  ),
                  TextFormField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock)),
                    focusNode: userPasswordFocusNode,
                    obscureText: true,
                    validator: (v) => v.trim().length > 5 ? null : "密码长度不能小于6位",
                  ),
                  TextField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock)),
                    focusNode: userPasswordFocusNode,
                    obscureText: true,
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      print('隐藏键盘');
                      userNameFocusNode.unfocus();
                      userPasswordFocusNode.unfocus();
                    },
                  ),
                  RaisedButton(
                    child: Text("登录"),
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      print(Form.of(context));
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
