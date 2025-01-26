import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';

class FirebaseService {
  static Future<void> addEventToFireStore(Event event) async {
    CollectionReference<Event> eventCollection = EventsCollection();
    DocumentReference documentReference = eventCollection.doc();
    event.id = documentReference.id;
    documentReference.set(event);
  }

  static CollectionReference<Event> EventsCollection() =>
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
            fromFirestore: (snapshot, _) => Event.fromjson(snapshot.data()!),
            toFirestore: (event, _) => event.tojson(),
          );
  static Future<List<Event>> getEventFireStore() async {
    CollectionReference<Event> eventCollection = EventsCollection();
    QuerySnapshot<Event> querySnapshot =
        await eventCollection.orderBy('datetime').get();

    return querySnapshot.docs.map((querySnap) => querySnap.data()).toList();
  }

  static Future<List<Event>> getEventById(String id) async {
    CollectionReference<Event> eventCollection = EventsCollection();
    QuerySnapshot<Event> querySnapshot =
        await eventCollection.where('id', isEqualTo: id).get();

    return querySnapshot.docs.map((querySnap) => querySnap.data()).toList();
  }

  static Future<void> deleteEventById(String id) async {
    CollectionReference<Event> eventCollection = EventsCollection();
    await eventCollection.doc(id).delete();
  }

  static Future<void> updateEventsById(Event event) async {
    CollectionReference<Event> eventCollection = EventsCollection();
    if (event.id.isNotEmpty) {
      await eventCollection.doc(event.id).update(event.tojson());
    } else {
      print("Event ID is empty. Cannot update event.");
    }
  }
}
