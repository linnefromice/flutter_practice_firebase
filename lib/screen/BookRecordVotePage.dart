import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_practice_firebase/models/BookRecord.dart';
import 'package:flutter_practice_firebase/screen/widgets/CommonBottomNavigationBar.dart';
import 'package:flutter_practice_firebase/services/BookRecordService.dart';


class BookRecordVotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BookRecordVotePage> {
  final TextEditingController _titleTextEditingController = new TextEditingController();
  final TextEditingController _descriptionTextEditingController = new TextEditingController();

  void _submitRecord() {
    BookRecordService.addBookRecord(
      _titleTextEditingController.text,
      _descriptionTextEditingController.text
    );
    _titleTextEditingController.text = '';
    _descriptionTextEditingController.text = '';
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Book Votes')
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox.expand(
              child: _buildBody(context),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: CommonBottomNavigationBar(
        context: context,
        selectedIndex: 0,
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return _buildAddAreaDialog(context);
          }
        );
      }
    );
  }

  Widget _buildAddAreaDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Add Record'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _titleTextEditingController,
            enabled: true,
            decoration: InputDecoration(
              labelText: 'New Book Title',
              hintText: 'Title',
              icon: Icon(Icons.book),
            ),
          ),
          TextField(
            controller: _descriptionTextEditingController,
            enabled: true,
            decoration: InputDecoration(
              labelText: 'New Book Description',
              hintText: 'Description',
              icon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton.icon(
          onPressed: _submitRecord,
          icon: Icon(Icons.add),
          label: Text('ADD'),
          color: Colors.blue,
        ),
        RaisedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.cancel),
          label: Text('CLOSE'),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: BookRecordService.selectBookRecords(),
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
    final record = BookRecord.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: _buildListItemContent(context, record)
      ),
    );
  }

  Widget _buildListItemContent(BuildContext context, BookRecord record) {
    return ListTile(
      leading: Text(record.votes.toString()),
      title: Text(record.title),
      subtitle: Text(record.description),
      trailing: _buildRemoveButton(record),
      onTap: () => BookRecordService.addVote(record),
    );
  }

  Widget _buildRemoveButton(BookRecord record) {
    return IconButton(
      icon: Icon(Icons.cancel),
      color: Colors.black,
      onPressed: () => BookRecordService.removeBookRecord(record)
    );
  }
}
