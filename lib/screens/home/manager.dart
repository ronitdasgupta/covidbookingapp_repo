import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidbookingapp_repo/screens/home/add_day_form.dart';
import 'package:covidbookingapp_repo/screens/home/days_list.dart';
// import 'package:covidbookingapp_repo/screens/home/manager_page.dart';
import 'package:covidbookingapp_repo/screens/home/user_list.dart';
import 'package:covidbookingapp_repo/screens/home/user_widget.dart';
import 'package:covidbookingapp_repo/services/auth.dart';
import 'package:covidbookingapp_repo/services/businessHoursCollection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/businessHours.dart';
import '../../models/users.dart';
import '../../services/usersCollection.dart';
import 'certain_days.dart';

class Manager extends StatelessWidget {

  final AuthService _auth = AuthService();


  //final slots = ['15 minutes', '30 minutes', ]

  @override
  Widget build(BuildContext context) {

    // final allBusinessHours = Provider.of<List<BusinessHours>>(context);
    // print(allBusinessHours);

    /*
    return ListView.builder(
        itemCount: allBusinessHours.length,
        itemBuilder: (context, index) {
          return DaysWidget(businessHours: allBusinessHours[index]);
        }
    );
     */

    final allBusinessHours = Provider.of<List<BusinessHours>>(context);

      return StreamProvider<List<BusinessHours>>.value(
        value: BusinessHoursCollection().businessInfo,
        initialData: [],
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              title: Text('Manager Page'),
              backgroundColor: Colors.black,
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),

                /*
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('statistics'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserList()),
                    );
                  },
                ),
                 */



                TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('add day'),
                  onPressed: () {
                    if(allBusinessHours.length == 7) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.error_outline, size: 32),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "All days have been selected",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else{
                      Navigator.push(context,
                        // MaterialPageRoute(builder: (context) => AddDayForm(businessHours: allBusinessHours[index])),
                        // MaterialPageRoute(builder: (context) => CertainDays()),
                        MaterialPageRoute(builder: (context) => AddDayForm()),
                      );
                    }
                  },
                ),
              ]
          ),
          body: DaysList(),
        ),
      );

  }
}
