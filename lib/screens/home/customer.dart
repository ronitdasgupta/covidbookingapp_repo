import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/users.dart';
import '../../services/auth.dart';
import 'package:covidbookingapp_repo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/screens/home/user_list.dart';

class Customer extends StatelessWidget {
  final AuthService _auth = AuthService();
  //const Customer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Users>?>.value(
      value: DatabaseService(uid: '').userInfo,
      initialData: null,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              title: Text('Customer Page'),
              backgroundColor: Colors.black,
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              ]
          ),
        //body: UserList(),
      ),
    );
  }
}
