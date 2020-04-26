import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference courtsCollection = Firestore.instance.collection('Korty');




  Stream<QuerySnapshot> get Names
  {
    return courtsCollection.snapshots();
  }

  Future<QuerySnapshot> getAllDocuments() {
    return courtsCollection.getDocuments();
  }



}