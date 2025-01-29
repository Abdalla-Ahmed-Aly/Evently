import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currenUser;
  updateuser(UserModel userModel) {
    currenUser = userModel;
    notifyListeners();
  }
}
