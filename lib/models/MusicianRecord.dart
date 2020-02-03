import 'package:cloud_firestore/cloud_firestore.dart';

class MusicianRecord {
  final String title;
  final String description;
  final int votes;
  final DocumentReference reference;

  MusicianRecord.fromMap(Map map, {this.reference})
      : assert(map['title'] != null),
        assert(map['description'] != null),
        assert(map['votes'] != null),
        title = map['title'],
        description = map['description'],
        votes = map['votes'];

  MusicianRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$description:$votes>";
}
