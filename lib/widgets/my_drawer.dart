import 'package:flutter/material.dart';
import 'package:flutter_osc/pages/about_page.dart';
import 'package:flutter_osc/pages/publish_tweet_page.dart';
import 'package:flutter_osc/pages/settings_page.dart';
import 'package:flutter_osc/pages/tweet_black_house.dart';

class MyDrawer extends StatelessWidget {
  final String headImgPath;
  final List menuTitles;
  final List menuIcons;

  MyDrawer({Key key, this.headImgPath, this.menuIcons, this.menuTitles})
      : assert(headImgPath != null),
        assert(menuIcons != null),
        assert(menuTitles != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0, //阴影
      child: ListView.separated(
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            if(index == 0){
              return Image.asset(
                  headImgPath,
                fit: BoxFit.cover,
              );
            }
            index -=1;
            return ListTile(
                leading: Icon(menuIcons[index]),
                title: Text(menuTitles[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                  switch(index){
                    case 0:
                      _navPush(context, PublishTweetPage());
                      break;
                    case 1:
                      _navPush(context, TweetBlackHousePage());
                      break;
                    case 2:
                      _navPush(context, AboutPage());
                      break;
                    case 3:
                      _navPush(context, SettingPage());
                      break;
                  }
              },
            );
          },
          separatorBuilder: (context,index){
              if(index == 0){
                  return Divider(
                    height: 0.0,
                  );
              }else{
                  return Divider(
                    height: 1.0,
                  );
              }
          },
          itemCount: menuTitles.length + 1),
    );
  }

  _navPush(BuildContext context,Widget page){
    Navigator.of(context).pop();//把drawer收起来
    Navigator.push(context,MaterialPageRoute(builder: (context) => page));
  }
}
