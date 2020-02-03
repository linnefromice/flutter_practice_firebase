import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firebase/models/MusicianRecord.dart';

class MusicianRecordService {
  static final _collection = Firestore.instance.collection('musician');

  static Stream<QuerySnapshot> selectMusicianRecords() {
    return _collection.snapshots();
  }

  static void addMusicianRecord(final String title) {
    _collection.add(<String, dynamic>{
      'title': title,
      'description': 'NEW RECORD',
      'votes': 1,
    });
  }

  static void addVote(final MusicianRecord record) {
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.reference);
      final fresh = MusicianRecord.fromSnapshot(freshSnapshot);
      await transaction
          .update(record.reference, {'votes': fresh.votes + 1});
    });
  }
}