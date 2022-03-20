import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/businessHours.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'days_widget.dart';

class DaysList extends StatefulWidget {
  // const DaysList({Key? key}) : super(key: key);

  @override
  _DaysListState createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  @override
  Widget build(BuildContext context) {


    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

      return ListView.builder(
        itemCount: allBusinessHours.length,
        itemBuilder: (context, index) {
          return DaysWidget(businessHours: allBusinessHours[index]);
        }
      );
  }
}
