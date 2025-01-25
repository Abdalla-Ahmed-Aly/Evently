import 'package:evently/firebase_service.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier {
  List<Event> events = [];

  Future<void> getEvents() async {
    events = await FirebaseService.getEventFireStore();
    notifyListeners();
  }
}
