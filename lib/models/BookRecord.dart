import 'package:cloud_firestore/cloud_firestore.dart';

class BookRecord {
  final String title;
  final int votes;
  final DocumentReference reference;

  BookRecord.fromMap(Map map, {this.reference})
      : assert(map['title'] != null),
        assert(map['votes'] != null),
        title = map['title'],
        votes = map['votes'];

  BookRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$votes>";
}