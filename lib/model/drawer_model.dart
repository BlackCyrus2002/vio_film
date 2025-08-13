import 'package:flutter/material.dart';

class DrawerModel{
  IconData leading;
  IconData trailing;
  String title;
  String subTitle;
  Widget widget;


  DrawerModel({
    required this.leading,
    required this.title,
    required this.widget,
    required this.subTitle,
    required this.trailing,
  });

}