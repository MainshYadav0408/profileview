import 'package:flutter/material.dart';
import '../utils/databaseClient.dart';
import '../models/users.dart';
import './signUpScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var db = new DatabaseHelper();
  @override
  void initState(){
    super.initState();
    _readUser();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new  ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: userList.length,
                  itemBuilder: (_, int index){
                    return Card(
                      color: Colors.white30, //todo res == 200 ? Colors.greenAccent : Colors.red,
                      child: new ListTile(
                        title: _username,
                        onLongPress: null,

                      ),
                    );
                  })),
          new Divider(
            height: 1.0,
          )
        ],
      ),

      floatingActionButton: new FloatingActionButton(
          tooltip: "Add User",
          backgroundColor: Colors.redAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed:(){
            Navigator.of(context).pushReplacementNamed('/signup');
          }
      ),

    );
  }
  _readUser()async{
    List users = await db.getUser();
    users.forEach((user){
      User user = User.map(users);
      print("db users: ${users}");
    });
  }
}
