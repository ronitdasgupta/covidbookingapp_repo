import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/screens/authenticate/authenticate.dart';
import 'package:covidbookingapp_repo/screens/wrapper.dart';
import 'package:covidbookingapp_repo/services/usersCollection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/appointmentInfo.dart';
import '../../services/appointmentsCollection.dart';
import '../../services/auth.dart';
import 'customer.dart';

class CustomerWrapper extends StatelessWidget {
  // const CustomerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    if(user == null) {
      return Authenticate();
      // return Wrapper();
    }


    return StreamProvider<UserData?>.value(
      value: UsersCollection(uid: user.uid ?? '').userData,
      initialData: null,
      child: Customer(),
    );
  }
}
