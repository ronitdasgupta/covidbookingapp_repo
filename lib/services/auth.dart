import 'package:covidbookingapp_repo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/*
class AuthService{
  AuthService(){
    Firebase.initializeApp();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User?> get user{
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
        //.map((Firebaseuser user)) => _userFromFirebaseUser(user));
        //.map(_userFromFirebaseUser);
        //.map((User user) => _userFromFirebaseUser(user));
  }
 */

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }


  // auth change user stream
  //Firebase User is now User?
  //onAuthStateChanged is now authStateChanges()

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign in with email & password

  // register with email & password

  // sign out
}