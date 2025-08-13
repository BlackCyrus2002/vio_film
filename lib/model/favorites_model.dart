class Favorites {
  int id;
  String type;
  int typeID;
  int state;

  Favorites({required this.id, required this.type, required this.typeID, required this.state});

  Favorites.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      type = map['type'],
      typeID = map['typeID'],
      state= map['state'];

}
