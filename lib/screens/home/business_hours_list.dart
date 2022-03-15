import 'package:covidbookingapp_repo/models/businessHours.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BusinessHoursList extends StatefulWidget {
  const BusinessHoursList({Key? key}) : super(key: key);

  @override
  _BusinessHoursListState createState() => _BusinessHoursListState();
}

class _BusinessHoursListState extends State<BusinessHoursList> {
  @override
  Widget build(BuildContext context) {

    /*
    final businessHours = Provider.of<List<BusinessHours>>(context);
    businessHours?.forEach((slot){
      print(slot.start);
      print(slot.end);
      print(slot.isholiday);
      print(slot.slotintervals);
      print(slot.slots);
    }
    );
     */

    /*
    if (businessHours != null && businessHours.isNotEmpty)
    {
      return ListView.builder(
        itemCount: businessHours.length,
        itemBuilder: (context, index){
          return UserWidget(user: users[index]);
        },
      );
    } else{
      return Container();
    }
     */

    return Container();
  }
}
