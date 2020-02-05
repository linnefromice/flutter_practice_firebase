import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firebase/models/MovieRecord.dart';

class MovieRecordService {
  static final _collection = Firestore.instance.collection('movie');

  static Stream<QuerySnapshot> selectMovieRecords() {
    return _collection.snapshots();
  }

  static void addMovieRecord(final String title, final String description) {
    _collection.add(<String, dynamic>{
      'title': title,
      'description': description,
      'votes': 1,
    });
  }

  static void addVote(final MovieRecord record) {
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.reference);
      final fresh = MovieRecord.fromSnapshot(freshSnapshot);
      await transaction
          .update(record.reference, {'votes': fresh.votes + 1});
    });
  }

  static void removeMovieRecord(final MovieRecord record) {
    final docId = record.reference.documentID;
    _collection.document(docId).delete();
  }
}