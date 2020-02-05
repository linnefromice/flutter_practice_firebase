import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_practice_firebase/screen/widgets/CommonBottomNavigationBar.dart';
import 'package:flutter_practice_firebase/models/MusicianRecord.dart';
import 'package:flutter_practice_firebase/services/MusicianRecordService.dart';


class MusicianRecordVotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MusicianRecordVotePage> {
  final TextEditingController _titleTextEditingController = new TextEditingController();
  final TextEditingController _descriptionTextEditingController = new TextEditingController();

  void _submitRecord() {
    MusicianRecordService.addMusicianRecord(
      _titleTextEditingController.text,
      _descriptionTextEditingController.text
    );
    _titleTextEditingController.text = '';
    _descriptionTextEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Musician Votes')
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
        selectedIndex: 2,
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
                    labelText: 'New Music Title',
                    hintText: 'Title',
                    icon: Icon(Icons.music_note),
                  ),
                ),
                TextField(
                  controller: _descriptionTextEditingController,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'New Music Description',
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
      stream: MusicianRecordService.selectMusicianRecords(),
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
    final record = MusicianRecord.fromSnapshot(data);

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

  Widget _buildListItemContent(BuildContext context, MusicianRecord record) {
    return ListTile(
      leading: Text(record.votes.toString()),
      title: Text(record.title),
      subtitle: Text(record.description),
      trailing: _buildRemoveButton(record),
      onTap: () => MusicianRecordService.addVote(record),
    );
  }

  Widget _buildRemoveButton(MusicianRecord record) {
    return IconButton(
        icon: Icon(Icons.cancel),
        color: Colors.black,
        onPressed: () => MusicianRecordService.removeMusicianRecord(record)
    );
  }
}
