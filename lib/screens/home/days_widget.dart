import 'package:covidbookingapp_repo/models/businessHours.dart';
import 'package:covidbookingapp_repo/services/businessHourDayCollection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/businessHoursCollection.dart';


class DaysWidget extends StatelessWidget {
  // const DaysWidget({Key? key}) : super(key: key);

  final BusinessHours businessHours;

  DaysWidget({ required this.businessHours });

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.black,
            ),
            title: Text(businessHours.day),
            subtitle: Text("Start Time: ${businessHours.start} \nEnd Time: ${businessHours.end}"),
          ),
        ),
      );
  }
}
