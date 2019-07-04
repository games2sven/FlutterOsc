import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc/constants/constants.dart';
import 'package:flutter_osc/models/user_info.dart';
import 'package:flutter_osc/utils/data_utils.dart';
import 'package:flutter_osc/utils/net_utils.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  UserInfo _userInfo;

  _getDetailInfo() {
    DataUtils.getAccessToken().then((accessToken) {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['dataType'] = 'json';
      params['access_token'] = accessToken;
      NetUtils.get(AppUrls.MY_INFORMATION, params).then((data) {
        if (data != null && data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          UserInfo userInfo = UserInfo();
          userInfo.uid = map['uid'];
          userInfo.name = map['name'];
          userInfo.gender = map['gender'];
          userInfo.province = map['province'];
          userInfo.city = map['city'];
          userInfo.platforms = map['platforms'];
          userInfo.expertise = map['expertise'];
          userInfo.joinTime = map['joinTime'];
          userInfo.lastLoginTime = map['lastLoginTime'];
          userInfo.portrait = map['portrait'];
          userInfo.fansCount = map['fansCount'];
          userInfo.favoriteCount = map['favoriteCount'];
          userInfo.followersCount = map['followersCount'];
          userInfo.notice = map['notice'];
          setState(() {
            _userInfo = userInfo;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '我的资料',
          style: TextStyle(
            color: Color(AppColors.APPBAR),
          ),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: buildSingleChildScrollView(),
    );
  }

  buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: _userInfo == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Column(
              children: <Widget>[
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '头像',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            image: DecorationImage(
                                image: NetworkImage(_userInfo.portrait),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '昵称',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.name,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '加入时间',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.joinTime,
                        // _userInfo.joinTime.split(' ')[0],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '所在地区',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          _userInfo.city,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '开发平台',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // 'Android,C/C++,J2ME/K-Java,Python,.NET/C#',
                            _userInfo.platforms.toString(),
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            '专长领域',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // '手机软件开发，服务器开发，软件开发管理',
                            _userInfo.expertise.toString(),
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '粉丝数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.fansCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '收藏数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.favoriteCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '关注数',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        _userInfo.followersCount.toString(),
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
    );
  }
}
