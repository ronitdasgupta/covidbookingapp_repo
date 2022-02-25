import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:flutter/material.dart';

class Manager extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      )
    );
  }
}
