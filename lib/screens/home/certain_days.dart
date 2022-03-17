import 'package:covidbookingapp_repo/screens/home/add_day_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/businessHours.dart';

class CertainDays extends StatefulWidget {
  // const CertainDays({Key? key}) : super(key: key);

  // final BusinessHours businessHours;

  // CertainDays({ required this.businessHours });

  @override
  _CertainDaysState createState() => _CertainDaysState();
}

class _CertainDaysState extends State<CertainDays> {
  @override
  Widget build(BuildContext context) {

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    print(allBusinessHours);

    // return AddDayForm(businessHours: allBusinessHours as BusinessHours); // DOES NOT WORK

    // return AddDayForm(businessHours: allBusinessHours.whereType<BusinessHours(),) // DOES NOT WORK

    // return AddDayForm(businessHours: allBusinessHours.runtimeType); // DOES NOT WORK

    // return AddDayForm(businessHours: allBusinessHours.single); // DOES NOT WORK

    // return AddDayForm(businessHours: allBusinessHours.first);

    return Container();


    /*
    return ListView.builder(
        itemCount: allBusinessHours.length,
        itemBuilder: (context, index) {
          return AddDayForm(businessHours: allBusinessHours[index]);
        }
    );
     */
  }
}
