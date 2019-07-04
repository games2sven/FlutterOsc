import 'package:flutter/material.dart';

class NavigationIconView{
  final BottomNavigationBarItem item;

  //title
  final String title;
  //icon path
  final String iconPath;
  //actived icon path
  final String activeIconPath;

  NavigationIconView({
    this.iconPath,
    this.activeIconPath,
    this.title
  }) :item = BottomNavigationBarItem(
    icon: Image.asset(iconPath, width: 20.0, height: 20.0,),
    activeIcon: Image.asset(activeIconPath, width: 20.0, height: 20.0,),
    title: Text(title),
  );

}