import 'package:covidbookingapp_repo/screens/home/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    // Might use this list for manager to view amount of users/customers
    final users = Provider.of<List<Users>?>(context);
    users?.forEach((user){
      print(user.aptDate);
      print(user.aptTime);
      print(user.day);
      print(user.email);
      print(user.name);
      print(user.phoneNumber);
    }
    );
    //print(users);
    if (users != null && users.isNotEmpty)
      {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index){
            return UserWidget(user: users[index]);
          },
        );
      } else{
          return Container();
    }
  }
}
