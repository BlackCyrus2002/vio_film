
import 'dart:convert';

import 'package:vio_film/model/categorie_model.dart';

import 'API_KEY.dart';
import 'package:http/http.dart';

class APIService{
  String baseUrl = "https://api.themoviedb.org/3";
  String apiKey = "api_key=";
  String pages ="page=";

  String prepareQuery(int page,String type){
    return "$baseUrl/$type/popular?$apiKey$API_KEY&$pages$page";
  }

  Future<CategoryModel> callAPI(int page,String type) async{
    final url = prepareQuery(page,type);
    final uri = Uri.parse(url);

    final call = await get(uri);

    if(call.statusCode == 200){
      Map<String,dynamic>data = json.decode(call.body);
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      return categoryModel;
    }
    else{
      throw Exception("Erreur de connexion");
    }
  }
}