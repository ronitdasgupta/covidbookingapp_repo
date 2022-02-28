import 'package:covidbookingapp_repo/screens/home/user_list.dart';
import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/usersCollection.dart';

class Manager extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Users>?>.value(
      value: UsersCollection(uid: '').userInfo,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text('Manager Page'),
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
        body: UserList(),
      ),
    );
  }
}
