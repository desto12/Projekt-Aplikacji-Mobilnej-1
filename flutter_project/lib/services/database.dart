import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference courtsCollection = Firestore.instance.collection('Korty');
  final CollectionReference reservCollection = Firestore.instance.collection('reservations');




  Stream getPost(String collection) async* { //get database instance
    QuerySnapshot data = await Firestore.instance.collection(collection).getDocuments();

    yield data.documents;
  }

  Future<QuerySnapshot> getAllDocuments() {
    return courtsCollection.getDocuments();
  }
  Stream<QuerySnapshot> getReservations(int courtId, DateTime startDay, DateTime endDay) {
    return reservCollection.where('court_id', isEqualTo: courtId).where('reservation_date',isGreaterThanOrEqualTo: startDay).where('reservation_date',isLessThanOrEqualTo: endDay).snapshots();
  }
}