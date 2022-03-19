class MyUser{
  final String? uid;
  final String? email;
  final bool emailVerified;

  MyUser({ this.uid, this.email, required this.emailVerified });
}

class UserData{
  final String uid;
  final String aptDate;
  final String aptTime;
  final String day;
  final String email;
  final String name;
  final String phoneNumber;

  UserData({required this.uid, required this.aptDate, required this.aptTime, required this.day, required this.email, required this.name, required this.phoneNumber});
}