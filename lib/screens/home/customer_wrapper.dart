import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/services/usersCollection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer.dart';

class CustomerWrapper extends StatelessWidget {
  // const CustomerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    return StreamProvider<UserData?>.value(
      value: UsersCollection(uid: user?.uid ?? '').userData,
      initialData: null,
      child: Customer(),
    );
  }
}
