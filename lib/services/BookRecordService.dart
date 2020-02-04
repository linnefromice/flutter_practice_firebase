import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firebase/models/BookRecord.dart';

class BookRecordService {
  static final _collection = Firestore.instance.collection('book');

  static Stream<QuerySnapshot> selectBookRecords() {
    return _collection.snapshots();
  }

  static void addBookRecord(final String title, final String description) {
    _collection.add(<String, dynamic>{
      'title': title,
      'description': description,
      'votes': 1,
    });
  }

  static void addVote(final BookRecord record) {
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.reference);
      final fresh = BookRecord.fromSnapshot(freshSnapshot);
      await transaction
          .update(record.reference, {'votes': fresh.votes + 1});
    });
  }
}