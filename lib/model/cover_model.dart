import 'package:vio_film/services/data_converse.dart';


class CoverModel {
  int id;
  List<dynamic> results;

  CoverModel({required this.id, required this.results});

  CoverModel.fromJson(Map<String, dynamic> coverModel) :
      id = coverModel['id'],
      results = DataConverse()
          .lisMappable(coverModel["results"])
          .map((e) => ResultsCover.fromJson(e))
          .toList();
}

class ResultsCover {
  String iso_639_1;
  String iso_3166_1;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String published_at;
  String id;

  ResultsCover({
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.published_at,
    required this.id,
  });

  ResultsCover.fromJson(Map<String, dynamic> results) :
      iso_639_1 = results['iso_639_1']??"",
      iso_3166_1 = results['iso_3166_1']??"",
      name = results['name']??"",
      key = results['key']??"",
      site = results['site']??"",
      size = results['size']??0,
      type = results['type']??"",
      official = results['official']??false,
      published_at = results['published_at']??"",
      id = results['id']??"";

  @override
  String toString() {
    return 'Results(iso_639_1: $iso_639_1, iso_3166_1: $iso_3166_1, name: $name,key: $key, site: $site, size: $size, type: $type, official: $official, published_at: $published_at, id: $id )';
  }
}
