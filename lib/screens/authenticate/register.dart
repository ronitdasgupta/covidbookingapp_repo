import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:covidbookingapp_repo/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  //const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? LoadingScreen() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Sign Up Page'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () {
                widget.toggleView();
              }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (String? value){
                  if(value != null && value.isEmpty){
                    return 'Enter an email';
                  }
                  return null;
                },
                //validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (String? value){
                    if(value != null && value.length < 6){
                      return 'Enter a password with more than 6 characters';
                    }
                    return null;
                  },
                  //validator: (val) => val.length < 6 ? 'Enter a password with more than 6 characters' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      // Validating through Firebase
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'please change the credentials';
                          loading = false;
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors. red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
