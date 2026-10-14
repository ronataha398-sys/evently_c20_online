import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/event_modele.dart';

class DbServices {
  static final FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<void> adds(EventModel event) async {
    final doc = firebase.collection("events").doc();

    event.id = doc.id;

    await doc.set(event.toJson());
  }
}