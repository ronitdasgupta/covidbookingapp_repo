import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/screens/authenticate/authenticate.dart';
import 'package:covidbookingapp_repo/screens/home/customer.dart';
import 'package:covidbookingapp_repo/screens/home/manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);

  // dynamic result = await _auth.signInAnon();
    // return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    } /*else if(user.uid == "AKjOEhHOlqXPRLaSXkLc6fm9wah2"){
      return Manager();
    }*/
     else{
      return Manager();
    }
  }
}
