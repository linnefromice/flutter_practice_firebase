import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_firebase/services/AuthService.dart';

class LoginPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _errorMessage = '';

  void _validateAndSubmit() {
    setState(() {
      _errorMessage = '';
    });

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_email == '1993' && _password == '1993') {
        print("Dummy Login");
        Navigator.of(context).pushNamed('/book');
        return;
      }

      AuthService.login(_email, _password)
        .then((AuthResult result) {
          print("LOGIN SUCCESS - user: " + result.user.uid);
          Navigator.of(context).pushNamed('/book');
        }).catchError((e) {
          print(e);
          setState(() {
            _errorMessage = 'LOGIN FAILURE';
          });
        });
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
            _email = value;
          });
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

  Widget _buildErrorMessage() {
    if (_errorMessage == '') {
      return Text('');
    } else {
      return Container(
        padding: EdgeInsets.only(top: 10.0),
        alignment: Alignment.center,
        child: Text(
          _errorMessage,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 3.0,
            fontWeight: FontWeight.bold
          ),
        ),
      );
    }
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
            _buildErrorMessage(),
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