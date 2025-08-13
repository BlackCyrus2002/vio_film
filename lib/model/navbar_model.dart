import 'package:flutter/material.dart';

  class NavbarModel{
  String title;
  Icon iconSelected;
  Icon iconUnSelected;

  IconData? get iconSelectedData => iconSelected.icon;
  IconData? get iconUnSelectedData => iconUnSelected.icon;

  NavbarModel({required this.title,required this.iconSelected,required this.iconUnSelected});
}