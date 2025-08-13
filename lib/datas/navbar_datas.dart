import 'package:flutter/material.dart';
import 'package:vio_film/model/navbar_model.dart';

class NavbarDatas{
  List<NavbarModel> tabBarElements = [
    NavbarModel(
      title: "Accueil",
      iconSelected: Icon(Icons.home, color: Colors.black),
      iconUnSelected: Icon(Icons.home_outlined),
    ),
    NavbarModel(
      title: "Favoris",
      iconSelected: Icon(Icons.favorite, color: Colors.black),
      iconUnSelected: Icon(Icons.favorite_border),
    ),
    NavbarModel(
      title: "Recherche",
      iconSelected: Icon(Icons.search, color: Colors.black),
      iconUnSelected: Icon(Icons.search),
    ),
    NavbarModel(
      title: "Vue recente",
      iconSelected: Icon(Icons.history, color: Colors.black),
      iconUnSelected: Icon(Icons.history),
    ),
  ];
}