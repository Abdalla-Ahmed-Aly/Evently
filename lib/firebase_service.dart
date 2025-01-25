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
  static Future<List<Event>> getEventFireStore(String? categoryId) async {
    CollectionReference<Event> eventCollection = EventsCollection();
    late QuerySnapshot<Event> querySnapshot;
    if (categoryId == null) {
      querySnapshot = await eventCollection.orderBy('datetime').get();
    } else {
      querySnapshot = await eventCollection
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('datetime')
          .get();
    }

    return querySnapshot.docs.map((querySnap) => querySnap.data()).toList();
  }
}
