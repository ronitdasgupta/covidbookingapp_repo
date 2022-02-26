import 'package:flutter/material.dart';
import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/models/users.dart';

class UserWidget extends StatelessWidget {

  final Users user;
  UserWidget({ required this.user });
  //const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black,
          ),
          title: Text(user.name),
          subtitle: Text('Appointment Date: ${user.aptDate} \nAppointment Time: ${user.aptDate}'),
        ),
      )
    );
  }
}
