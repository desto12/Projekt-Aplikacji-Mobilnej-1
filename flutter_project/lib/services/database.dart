
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final CollectionReference courtsCollection = Firestore.instance.collection(
      'Korty');
  final CollectionReference reservCollection = Firestore.instance.collection(
      'reservations');

  Stream getPost(String collection) async* {
    //get database instance
    QuerySnapshot data = await Firestore.instance.collection(collection)
        .getDocuments();

    yield data.documents;
  }

  Future<QuerySnapshot> getAllDocuments() {
    return courtsCollection.getDocuments();
  }
checkIsFree2(int courtId, DateTime endDate, DateTime startDate) async{
  var docStart = await reservCollection.where('court_id', isEqualTo: courtId).where(
      'reservation_date', isGreaterThanOrEqualTo: startDate).where(
      'reservation_date', isLessThanOrEqualTo: endDate).getDocuments();
  var docEnd = await reservCollection.where('court_id', isEqualTo: courtId).where(
      'end_date', isGreaterThanOrEqualTo: startDate).where(
      'end_date', isLessThanOrEqualTo: endDate).getDocuments();
  print('JEST PUSTA:' + docStart.documents.isEmpty.toString());
  List<bool> isEmptyList = List<bool>();
  isEmptyList.add(docStart.documents.isEmpty);
  isEmptyList.add(docEnd.documents.isEmpty);
  return isEmptyList;
}
  Stream<QuerySnapshot> getReservations(int courtId, DateTime startDay,
      DateTime endDay) {
    return reservCollection.where('court_id', isEqualTo: courtId).where(
        'reservation_date', isGreaterThanOrEqualTo: startDay).where(
        'reservation_date', isLessThanOrEqualTo: endDay).snapshots();
  }


  addItem(var uid, int courtId, String name, DateTime startDate, DateTime endDate) {
    reservCollection.add({
      'uid': uid,
      'court_id': courtId,
      'name': name,
      'reservation_date': startDate,
      'end_date': endDate
    });
  }
  deleteItem(var id)
  {
    reservCollection.document(id).delete();

    }


  Stream getCourt(String id) async* {
    DocumentSnapshot data = await Firestore.instance.collection('Korty').document(id).get();

    yield data;
  }

  }