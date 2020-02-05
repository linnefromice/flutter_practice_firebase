import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_practice_firebase/models/MovieRecord.dart';
import 'package:flutter_practice_firebase/screen/widgets/CommonBottomNavigationBar.dart';
import 'package:flutter_practice_firebase/services/MovieRecordService.dart';


class MovieRecordVotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieRecordVotePage> {
  final TextEditingController _titleTextEditingController = new TextEditingController();
  final TextEditingController _descriptionTextEditingController = new TextEditingController();

  void _submitRecord() {
    MovieRecordService.addMovieRecord(
      _titleTextEditingController.text,
      _descriptionTextEditingController.text,
    );
    _titleTextEditingController.text = '';
    _descriptionTextEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Movie Votes')
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: _buildAddArea(context),
          ),
          Expanded(
            child: SizedBox.expand(
              child: _buildBody(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        context: context,
        selectedIndex: 1,
      ),
    );
  }

  Widget _buildAddArea(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _titleTextEditingController,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'New Movie Title',
                    hintText: 'Title',
                    icon: Icon(Icons.movie),
                  ),
                ),
                TextField(
                  controller: _descriptionTextEditingController,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'New Movie Description',
                    hintText: 'Description',
                    icon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
              ],
            )
        ),
        Expanded(
          flex: 1,
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.lightBlue,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: _submitRecord
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: MovieRecordService.selectMovieRecords(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = MovieRecord.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.title),
          subtitle: Text(record.description),
          trailing: Text(record.votes.toString()),
          onTap: () => MovieRecordService.addVote(record),
        ),
      ),
    );
  }
}
