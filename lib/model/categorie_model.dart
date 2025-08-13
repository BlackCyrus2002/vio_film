import 'package:vio_film/services/data_converse.dart';

class CategoryModel {
  int page;
  List<dynamic> results;
  int total_pages;
  int total_results;

  CategoryModel({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });

  CategoryModel.fromJson(Map<String, dynamic> map)
    : page = map['page'],
      results = DataConverse()
          .lisMappable(map["results"])
          .map((e) => Results.fromJson(e))
          .toList(),
      total_pages = map['total_pages'],
      total_results = map['total_results'];
}
class Results {
  final bool adult;
  final String? backdrop_path;
  final List<int> genre_ids;
  final int id;
  final String? original_language;
  final String? original_title;
  final String? overview;
  final double popularity;
  final String? poster_path;
  final String? release_date;
  final String? title;
  final bool video;
  final double vote_average;
  final int vote_count;
  final List<String> origin_country;
  final String first_air_date;
  final String name;

  Results({
    required this.adult,
    required this.backdrop_path,
    required this.genre_ids,
    required this.id,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.release_date,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
    required this.origin_country,
    required this.first_air_date,
    required this.name,
  });

  Results.fromJson(Map<String, dynamic> map)
      : adult = map['adult'] ?? false,
        backdrop_path = map["backdrop_path"]??"",
        genre_ids = List<int>.from(map['genre_ids'] ?? []),
        id = map["id"] ?? 0,
        original_language = map["original_language"]??"",
        original_title = map["original_title"]??"",
        overview = map["overview"]??"",
        popularity = (map["popularity"] as num?)?.toDouble() ?? 0.0,
        poster_path = map["poster_path"]??"",
        release_date = map["release_date"]??"",
        title = map["title"]??"",
        video = map["video"] ?? false,
        vote_average = (map["vote_average"] as num?)?.toDouble() ?? 0.0,
        vote_count = map["vote_count"] ?? 0,
        origin_country = List<String>.from(map['origin_country'] ?? []),
        first_air_date = map["first_air_date"] ?? "",
        name = map["name"] ?? ""
  ;

  @override
  String toString() {
    return 'Results(title: $title, release_date: $release_date, vote: $vote_average,orgin_country: $origin_country, first_air_date: $first_air_date, name: $name )';
  }
}
