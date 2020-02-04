import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  void _validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // TODO: validation & authentication & delete debug code
      print("Email:" + _email);
      print("Password:" + _password);
      Navigator.of(context).pushNamed('/book');
    }
  }

  Widget _buildEmailInput() {
    return Container(
      padding: EdgeInsets.only(top: 100.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) {
          setState(() {
            _password = value;
          });
          print("Email.onSaved: " + value);
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          )
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) {
          setState(() {
            _password = value;
          });
          print("Password.onSaved: " + value);
        },
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      padding: EdgeInsets.only(top: 45.0),
      child: SizedBox(
        height: 40.0,
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0, color: Colors.white)
          ),
          onPressed: _validateAndSubmit,
        ),
      )
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildEmailInput(),
            _buildPasswordInput(),
            _buildPrimaryButton(),
          ],
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vote App Login Form"),
      ),
      body: Stack(
        children: <Widget>[
          _buildForm()
        ],
      )
    );
  }
}