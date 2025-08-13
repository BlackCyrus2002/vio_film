import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  String key = "preferences";

  //Obtenir
  Future<List<String>> getPreferences()async{
    final preferences = await SharedPreferences.getInstance();
    final list = preferences.getStringList(key)??[];

    return list??[];
  }

  //Ajouter
  Future<bool> addPreferences(String title)async{
    final preferences = await SharedPreferences.getInstance();
    var lists = preferences.getStringList(key)??[];

    lists.add(title);
    return preferences.setStringList(key, lists);
  }

  //Supprimer
  Future <bool> removePreferences(String title)async{
    final preferences = await SharedPreferences.getInstance();
    final lists = preferences.getStringList(key)??[];

    lists.remove(title);
    return preferences.setStringList(key, lists);
  }
}