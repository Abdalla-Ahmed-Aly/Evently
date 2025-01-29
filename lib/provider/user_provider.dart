import 'package:evently/firebase_service.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currenUser;
  updateuser(UserModel? userModel) {
    currenUser = userModel;
    notifyListeners();
  }

  bool checkWithFavorite(String eventId) {
    return currenUser!.eventFavoriteIds.contains(eventId);
  }

  void addEventTofavorite(String eventId) {
    FirebaseService.addEventTofavorite(eventId);
    currenUser!.eventFavoriteIds.add(eventId);
    notifyListeners();
  }

  void removeEventTofavorite(String eventId) {
    FirebaseService.removwEventTofavorite(eventId);
    currenUser!.eventFavoriteIds.remove(eventId);
    notifyListeners();
  }
}
