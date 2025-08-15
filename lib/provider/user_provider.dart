import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../services/database_client.dart';

class UserProvider extends ChangeNotifier{
  UserModel? user;

  Future<void> getUser() async {
    user = await DataBaseClient().oneUser();
    notifyListeners();
  }
}