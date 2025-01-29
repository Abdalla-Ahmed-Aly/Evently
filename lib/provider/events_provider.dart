import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<Event> allevent = [];
  List<Event> filterevent = [];
  List<Event> favoriteevents = [];

  Category? selectedCategory;

  Future<void> getEvents() async {
    allevent = await FirebaseService.getEventFireStore();
    filterEventsByCategory(selectedCategory);
    notifyListeners();
  }
  // Future<void> getEventsByID(String id) async {
  //   allevent = await FirebaseService.getEventById(id);
  //   filterEventsByCategory(selectedCategory);
  //   notifyListeners();
  // }

  void filterEventsByCategory(Category? category) {
    selectedCategory = category;
    if (category == null) {
      filterevent = allevent;
    } else {
      filterevent =
          allevent.where((event) => event.category == category).toList();
    }
    notifyListeners();
  }

  void filtereventsByFavorite(List<String> favoriteeventsIDS) {
   favoriteevents= allevent.where((event) => favoriteeventsIDS.contains(event.id)).toList();
    notifyListeners();
  }
}
