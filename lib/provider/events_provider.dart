
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<Event> events = [];
  Category? selectedCategory;

  Future<void> getEvents() async {
    events = await FirebaseService.getEventFireStore(selectedCategory?.id);
    notifyListeners();
  }

  getEventsByCategory(Category? category) {
    selectedCategory = category;
    getEvents();
  }
}
