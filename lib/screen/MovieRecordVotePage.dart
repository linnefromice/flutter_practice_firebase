import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_practice_firebase/models/MovieRecord.dart';
import 'package:flutter_practice_firebase/services/MovieRecordService.dart';


class MovieRecordVotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MovieRecordVotePage> {
  final TextEditingController _textEditingController = new TextEditingController();
  int _selectedIndex = 1;

  void _submitRecord() {
    MovieRecordService.addMovieRecord(_textEditingController.text);
    _textEditingController.text = '';
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildAddArea(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: TextField(
            controller: _textEditingController,
            enabled: true,
            decoration: InputDecoration(
              labelText: 'New Movie Title',
              hintText: 'Movie Title',
              icon: Icon(Icons.movie),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
              child: Text(
                "SUBMIT",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: _submitRecord
          ),
        )
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Book'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          title: Text('Movie'),
        ),
      ],
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/book');
        break;
      case 1:
        Navigator.of(context).pushNamed('/movie');
        break;
      default:
        break;
    }
  }
}
