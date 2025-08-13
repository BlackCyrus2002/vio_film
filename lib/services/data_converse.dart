class DataConverse{
  List<Map<String,dynamic>> lisMappable(List<dynamic> list){
    return list.map((e) => e as Map<String, dynamic>).toList();
  }
}