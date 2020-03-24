import 'package:flutter/material.dart';
import 'package:wanandroid/net/HttpUtils.dart';
import 'package:wanandroid/utils/SpUtils.dart';
import 'package:wanandroid/utils/ToastUtils.dart';

import 'login_back_bean_entity.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var _loginStatus = false;

  var _userName = "";

  @override
  void initState() {
    super.initState();
    _loginStatus = getLoginStatus();
    SpUtils.getUserName((name) {
      _userName = name;
    });
  }

  bool getLoginStatus() {
    SpUtils.getUserName((userName) {
      if (userName.toString().isNotEmpty) {
        SpUtils.getPwd((pwd) {
          if (pwd.toString().isNotEmpty) {
            setState(() {
              _loginStatus = true;
            });
            return true;
          }
        });
      }
    });
    return false;
  }

  Widget getWidget(context) {
    if (_loginStatus) {
      return _buildLoginedView(context);
    } else {
      return _buildLoginView(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }

  Widget _buildLoginedView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          color: Colors.lightBlue,
          alignment: Alignment.topCenter,
          height: 100,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565718970406&di=8f5826a098c40594d11580163b6f4296&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20190813%2Fc12744b9792242d7b02af2d24a89fc57.jpeg"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _userName,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        RaisedButton(
          child: Text("退出登陆"),
          onPressed: () {
            SpUtils.putUserName("");
            SpUtils.putPwd("");
            setState(() {
              _loginStatus = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildLoginView(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    var _scaffoldkey = new GlobalKey<ScaffoldState>();

    void login() {
      if (userNameController.text.isEmpty) {
        showToast("手机号不能为空");
        return;
      }
      if (pwdController.text.isEmpty) {
        var snackBar = SnackBar(content: Text('密码不能为空'));
        _scaffoldkey.currentState.showSnackBar(snackBar);
        return;
      }

      HttpUtils.instance.login(userNameController.text, pwdController.text,
          (LoginBackBeanEntity loginBackBean) {
        if (loginBackBean.errorCode != null && loginBackBean.errorCode == 0) {
          //登陆成功
          SpUtils.putUserName(userNameController.text);
          SpUtils.putPwd(pwdController.text);
          setState(() {
            _loginStatus = true;
            SpUtils.getUserName((name) {
              _userName = name;
            });
          });
          print("denglu chengg ");
        }
      });
    }

    return Column(
      children: <Widget>[
        new TextField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            icon: Icon(Icons.perm_identity),
            labelText: "请输入用户名",
            helperText: "注册的用户名",
          ),
          onChanged: (v) {
            print("用户名是：$v");
          },
          onSubmitted: (v) {
            print("提交的用户名是:$v");
          },
        ),
        new TextField(
          controller: pwdController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            icon: Icon(Icons.pages),
            labelText: "请输入密码",
            helperText: "不少于6位数字的密码",
          ),
          obscureText: true,
          onChanged: (v) {
            print("密码是：$v");
          },
          onSubmitted: (v) {
            print("提交的密码是:$v");
          },
        ),
        RaisedButton(
          onPressed: () {
            login();
          },
          child: Text("登录"),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
        ),
      ],
    );
  }
}
