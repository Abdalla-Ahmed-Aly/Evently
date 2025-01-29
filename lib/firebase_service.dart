import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  static CollectionReference<UserModel> UsersCollection() =>
      FirebaseFirestore.instance.collection('Users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (User, _) => User.toJson(),
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

  static Future<UserModel> Registe(
      {required String name,
      required String email,
      required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(
      name: name,
      email: email,
      password: password,
      id: userCredential.user!.uid,
      eventFavoriteIds: [],
    );
    CollectionReference<UserModel> UserCollection = UsersCollection();
    await UserCollection.doc(userCredential.user!.uid).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> user = UsersCollection();
    DocumentSnapshot<UserModel> docSnapshot =
        await user.doc(userCredential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> Logout() => FirebaseAuth.instance.signOut();

  static Future<void> addEventTofavorite(String eventId) async {
    CollectionReference<UserModel> UserCollection = UsersCollection();
    return UserCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'eventFavoriteIds': FieldValue.arrayUnion([eventId])
    });
  }

  static Future<void> removwEventTofavorite(String eventId) async {
    CollectionReference<UserModel> UserCollection = UsersCollection();
    return UserCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'eventFavoriteIds': FieldValue.arrayRemove(
        [eventId],
      )
    });
  }
}
