import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/models/businessHours.dart';
import 'package:covidbookingapp_repo/models/days.dart';
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

    /*
    ChangeNotifierProvider(
      create: (context) => Days(),

    ),
     */


    // final allBusinessHours = Provider.of<List<BusinessHours>?>(context);

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

    //final weekDays = Provider.of<QuerySnapshot>(context);
    //print(weekDays.docs);



    /*
    return ChangeNotifierProvider<BusinessHours>(
      create: (context) =>
    )
     */

    /*
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<List<BusinessHours>>(
          create: (_) =>
        )
      ],
    ),
     */

    /*
    builder: (context) {
      return Text(context.watch<List<BusinessHours>>(context));
    };
     */

    // List<String> days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

      return ListView.builder(
        itemCount: allBusinessHours.length,
        itemBuilder: (context, index) {
          return DaysWidget(businessHours: allBusinessHours[index]);
        }
      );



    /*
    return ListView.builder(
      itemCount: allBusinessHours.length,
      itemBuilder: (context, index) {
        return DaysWidget(businessHours: allBusinessHours[index]);
      },
    );
     */
  }
}
