
import 'dart:convert';

import 'package:vio_film/model/cover_model.dart';

import 'API_KEY.dart';
import 'package:http/http.dart';

class CoverService{
  String baseUrl = "https://api.themoviedb.org/3";
  String apiKey = "api_key=";

  String prepareQuery(int id,String type){
    return "$baseUrl/$type/$id/videos?$apiKey$API_KEY";
  }

  Future<CoverModel> callAPI(int id,String type) async{
    final url = prepareQuery(id,type);
    final uri = Uri.parse(url);

    final call = await get(uri);

    if(call.statusCode == 200){
      Map<String,dynamic>data = json.decode(call.body);
      CoverModel coverModel = CoverModel.fromJson(data);
      return coverModel;
    }
    else{
      throw Exception("Erreur de connexion");
    }
  }
}