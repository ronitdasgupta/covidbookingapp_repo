import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/screens/authenticate/authenticate.dart';
import 'package:covidbookingapp_repo/screens/authenticate/verify.dart';
import 'package:covidbookingapp_repo/screens/home/customer.dart';
import 'package:covidbookingapp_repo/screens/home/customer_wrapper.dart';
import 'package:covidbookingapp_repo/screens/home/days_list.dart';
import 'package:covidbookingapp_repo/screens/home/manager.dart';
import 'package:covidbookingapp_repo/screens/home/manager_page.dart';
import 'package:covidbookingapp_repo/screens/home/user_list.dart';
// import 'package:covidbookingapp_repo/screens/home/manager_homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/businessHours.dart';
import '../services/usersCollection.dart';

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
    } else if(user.uid == "QsaU7IWGLlhb4wPJlbyRyP1FfMi1"){
      return Manager();
      // return ManagerPage();
    }
     else{
      // return Customer();
      // return CustomerWrapper();
      return VerifyScreen();
    }
  }
}
