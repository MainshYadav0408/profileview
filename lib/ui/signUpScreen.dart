import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:profileview/models/users.dart';
import 'package:profileview/utils/databaseClient.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
var db = new DatabaseHelper();
  Future<Function> handleSubmit(var _userName, String _password, String _fName, String _lName, String _dob, String _gender, var _phone, String _email)async {
    _usernameController.clear();
    _passwordController.clear();
    _firstnameController.clear();
    _lastnameController.clear();
    _genderController.clear();
    _dobController.clear();
    _emailController.clear();
    _phoneController.clear();
    final List<User> userList = <User>[];

    User user = new User(_userName, _password, _fName, _lName, _dob, _gender, _phone, _email);
    int saveUserId = await db.saveUser(user);
//    User addedUser = await db.getUser(saveUserId);
    setState((){
//      userList.insert(0, addedUser);
    });
    print("saved user id: $saveUserId");
  }

  void displayDialog(context, title, text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
                title: Text(title),
                content: Text(text)
            ),
      );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
                key: _formKey,
                autovalidate: true,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(60.0, 110.0, 0.0, 0.0),
                      child: Text('Sign-Up',
                        style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.person_outline),
                        hintText: 'Enter Your Roll No./Employee ID',
                        labelText: 'USERNAME',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new TextFormField(
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter Your First and Last name',
                          labelText: 'First Name'
                      ),
                    ),
                    new TextFormField(
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter Last name',
                          labelText: 'Last Name'
                      ),
                    ),
                    new TextFormField(
                      controller: _dobController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'yyyy/mm/dd',
                        labelText: 'Dob',
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    new TextFormField(
                      controller: _genderController,
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Male/Female',
                          labelText: 'Gender'
                      ),
                    ),
                    new TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'Enter a email address',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.security),
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            var userName  = _usernameController.text;
                            var password  = _passwordController.text;
                            var fName = _firstnameController.text;
                            var lName  = _lastnameController.text;
                            var dob       = _dobController.text;
                            var gender    = _genderController.text;
                            var phone     = _phoneController.text;
                            var email     = _emailController.text;

                            if (userName.length < 4)
                              displayDialog(context, "Invalid Username",
                                   "The username should be at least 4 characters long");
                            else if (password.length < 4)
                              displayDialog(context, "Invalid Password",
                                  "The password should be at least 4 characters long");
                            else if (fName.length == null)
                              displayDialog(context, "Invalid firstname",
                                  "The firstname should be at least 4 characters long");
                            else if (lName.length == null)
                              displayDialog(context, "Invalid lastname",
                                  "The lastname should be at least 4 characters long");
                            else if (dob == "yyyy/mm/dd")
                              displayDialog(context, "Invalid DOB",
                                  "The DOB should be in this dd/mm/yyy manner");
                            else if (phone.length < 10)
                              displayDialog(context, "Invalid Password",
                                  "The password should be at least 4 characters long");
                            else if (EmailValidator.validate(email))
                              displayDialog(context, "Invalid email",
                                  "Invalid email address");
                            else {
                              handleSubmit(
                                _usernameController.text,
                                _passwordController.text,
                                _firstnameController.text,
                                _lastnameController.text,
                                  _dobController.text,
                                  _genderController.text,
                                _phoneController.text,
                                _emailController.text
                              );
                              _usernameController.clear();
                            _passwordController.clear();
                            _firstnameController.clear();
                            _lastnameController.clear();
                              _dobController.clear();
                              _genderController.clear();
                            _phoneController.clear();
                              _emailController.clear();

                            }
                          },
                          child: Center(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child:
                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )))
    );
  }
}