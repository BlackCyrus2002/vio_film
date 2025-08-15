class UserModel {
  int id;
  String name;
  String number;
  String email;
  String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.image,
  });

  UserModel.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      number = map['number'],
      email = map['email'],
      image = map['image'];
}
