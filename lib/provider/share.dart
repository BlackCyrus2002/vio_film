import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProvider extends ChangeNotifier{
  Future<void> share(movie) async {
    await SharePlus.instance.share(
      ShareParams(
        title: '${movie.title}${movie.name}',
        text:
        "Découvrez ${movie.title == "" ? "cette série" : "ce film"}  : ${movie.title}${movie.name}\n\nhttps://www.themoviedb.org/movie/${movie.id}",
      ),
    );
  }
}