import 'package:covidbookingapp_repo/screens/authenticate/verify.dart';
import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:covidbookingapp_repo/services/usersCollection.dart';
import 'package:covidbookingapp_repo/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
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
  String name = '';
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);


    return loading ? LoadingScreen() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Register User'),
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
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              sizedBoxHeight,
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name', prefixIcon: Icon(Icons.person)),
                  validator: (String? value){
                    if(value != null && value.isEmpty){
                      return 'Enter a name';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => name = val);
                  }
              ),
              sizedBoxHeight,
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email', prefixIcon: Icon(Icons.email)),
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
              sizedBoxHeight,
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.password)),
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
              SizedBox(height: 3.0),
              ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      // Validating through Firebase
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, phoneNumber).then((_){
                      });
                      if(result == null) {
                        setState(() {
                          error = 'please change the credentials';
                          loading = false;
                        });
                      }
                    }
                  }
              ),
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
