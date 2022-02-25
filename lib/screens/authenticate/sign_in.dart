import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:covidbookingapp_repo/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  //const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
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
        title: Text('Login Page'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Up'),
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
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    // Validating through Firebase
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
