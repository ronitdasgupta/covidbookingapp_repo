import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Customer extends StatelessWidget {
  final AuthService _auth = AuthService();
  //const Customer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        )
    );
  }
}
