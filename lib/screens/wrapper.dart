import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/screens/authenticate/authenticate.dart';
import 'package:covidbookingapp_repo/screens/home/manager.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    final user = Provider.of<MyUser>(context);
    print(user);
     */

    // return either Home or Authenticate widget
    return Authenticate();
  }
}
