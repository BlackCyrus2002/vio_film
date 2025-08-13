
import 'package:flutter/material.dart';
import 'package:vio_film/model/pages_model.dart';
import 'package:vio_film/view/widget/favorite/favorite.dart';
import 'package:vio_film/view/widget/home/home_movies.dart';
import 'package:vio_film/view/widget/recent/recent.dart';
import 'package:vio_film/view/widget/search/search.dart';

class PagesDatas{
  List<PagesModel> pages = [
    PagesModel(title: "Accueil", pages: HomeMovies()),
    PagesModel(title: "Favoris", pages: Favorite()),
    PagesModel(title: "Pour vous", pages: Search()),
    PagesModel(title: "Vue recente", pages: Recent()),

  ];
}