import 'package:flutter/material.dart';

class User extends StatelessWidget {
  var _userName;
  String _fName;
  String _lName;
  var _dob;
  String _gender;
  var _phone;
  var _email;
  var _password;
  User(this._userName, this._password, this._fName, this._lName, this._dob, this._gender, this._phone, this._email );

  User.map(dynamic obj){
    this._userName = obj["userName"];
    this._password = obj["password"];
    this._fName = obj["fName"];
    this._lName = obj["lName"];
    this._dob = obj["dob"];
    this._gender = obj["gender"];
    this._phone = obj["phone"];
    this._email = obj["email"];
  }

  int get usrName => _userName;
  String get password => _password;
  String get fName => _fName;
  String get lName => _lName;
  String get dob => _dob;
  String get gender => _gender;
  String get email => _email;
  int get phone => _phone;

  Map<String, dynamic> tomap(){
    var map = new Map<String, dynamic>();
    map["userName"] = _userName;
    map["password"] = _password;
    map["fName"] = _fName;
    map["lName"] = _lName;
    map["dob"] = _dob;
    map["gender"] = _gender;
    map["phone"] = _phone ;
    map["email"] = _email;
    if(_userName != null){
      map['userName'] = _userName;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic>map){
    this._userName = map["userName"];
    this._password = map["password"];
    this._fName = map["fName"];
    this._lName = map["lName"];
    this._dob = map["dob"];
    this._gender = map["gender"];
    this._phone = map["phone"];
    this._email = map["email"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text('$_userName',
          style: TextStyle(
            color: Colors.white30,
            fontSize: 17
          ),),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text('Full Name: $_fName'' ''$lName',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 14,
              fontStyle: FontStyle.italic
            )
            )
          )
        ],
      ),
    );
  }
}
