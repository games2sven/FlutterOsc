import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc/constants/constants.dart';
import 'package:flutter_osc/utils/data_utils.dart';
import 'package:flutter_osc/utils/net_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      print('LoginWebPage onUrlChanged: $url');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      //      https://www.dongnaoedu.com/?code=6hHYoH&state=
      if (url != null && url.length > 0 && url.contains('?code=')) {
        //登录成功了
        //提取授权码code
        String code = url.split('?')[1].split('&')[0].split('=')[1];
        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
          print('$data');
          if (data != null) {
            Map<String, dynamic> map = json.decode(data);
            if (map != null && map.isNotEmpty) {
              //保存token等信息
              DataUtils.saveLoginInfo(map);
              //弹出当前路由，并返回refresh通知我的界面刷新数据
              Navigator.pop(context, 'refresh');
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebviewPlugin.close();
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(  '登录开源中国',
        style: TextStyle(
          color: Color(AppColors.APPBAR),
        ),),
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
        url: AppUrls.OAUTH2_AUTHORIZE +'?response_type=code&client_id='+
        AppInfos.CLIENT_ID + '&redirect_uri='+AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)), //0412 added
      ),
      withJavascript: true,
      withLocalStorage: true,//允许本地存储
      withZoom: true,//允许网页缩放
    );
  }
}
