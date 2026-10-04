import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class FirebaseResult<T> {}

class FirebaseSuccess<T> extends FirebaseResult<T> {
  final T data;
  FirebaseSuccess(this.data);
}

class FirebaseError<T> extends FirebaseResult<T> {
  final String message;
  FirebaseError(this.message);
}



Future<FirebaseResult<T>> getData<T>(
  DatabaseReference ref,
  T Function(dynamic json) mapper,
) async {
  try {
    final snapshot = await ref.get();

    if (!snapshot.exists) {
      return FirebaseError(FirebaseException(plugin: "auth", code: "404", message: "Aucune donnée trouvée").message ?? "Aucune donnée trouvée");
    }

    final raw = snapshot.value;

    return FirebaseSuccess(mapper(raw));
  } catch (e) {
    log("------------------------------>>1 $e");
    return FirebaseError(FirebaseException(plugin: "auth", code: "", message: e.toString()).message?? '');
  }
}



Future<FirebaseResult<T>> getDocument<T>(
  DocumentReference ref,
  T Function(Map<String, dynamic> json) mapper,
) async {
  try {
    final doc = await ref.get();

    if (!doc.exists) {
      return FirebaseError("Document inexistant");
    }

    return FirebaseSuccess(mapper(doc.data() as Map<String, dynamic>));
  } catch (e) {
    log("------------------------------>>2 $e");
    return FirebaseError(FirebaseException(plugin: "auth", code: "", message: e.toString()).message?? '');
  }
}
