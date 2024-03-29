import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc/common/event_bus.dart';
import 'package:flutter_osc/constants/constants.dart';
import 'package:flutter_osc/pages/login_web_page.dart';
import 'package:flutter_osc/utils/data_utils.dart';
import 'package:flutter_osc/utils/net_utils.dart';
import 'package:flutter_osc/widgets/news_list_item.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {

  bool isLogin = false;
  int curPage = 1;
  List newsList;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getNewsList(true);
      }
    });
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      //获取新闻列表
      getNewsList(false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = false;
      });
    });
  }

  getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
        if(isLogin){
          DataUtils.getAccessToken().then((accessToken){
            if (accessToken == null || accessToken.length == 0) {
              return;
            }
            Map<String, dynamic> params = Map<String, dynamic>();
            params['access_token'] = accessToken;
            params['catalog'] = 1;
            params['page'] = curPage;
            params['pageSize'] = 10;
            params['dataType'] = 'json';
            
            NetUtils.get(AppUrls.NEWS_LIST, params).then((data){
              if (data != null && data.isNotEmpty) {
                Map<String, dynamic> map = json.decode(data);
                List _newsList = map['newslist'];
                if (!mounted) return;
                setState(() {
                  if (isLoadMore) {
                    newsList.addAll(_newsList);
                  } else {
                    newsList = _newsList;
                  }
                });
              }
            });
          });
        }
    });
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {

    if(!isLogin){
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('由于openapi限制，必须登录才能获取资讯！'),
              InkWell(
                onTap: () async{
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginWebPage()));
                  if (result != null && result == 'refresh') {
                    //登录成功
                    eventBus.fire(LoginEvent());
                  }
                },
                child: Text('去登录'),
              ),
            ],
          ),
      );
    }

    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: buildListView(),
    );
  }

  Widget buildListView() {
    if (newsList == null) {
      getNewsList(false);
      return CupertinoActivityIndicator();
    }

    return ListView.builder(
      controller: _controller,
      itemCount: newsList.length,
      itemBuilder: (context,index){
        return NewsListItem(newsList:newsList[index]);
      },
    );
  }

}
