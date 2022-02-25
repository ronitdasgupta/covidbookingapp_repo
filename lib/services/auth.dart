import 'package:covidbookingapp_repo/models/user.dart';
import 'package:covidbookingapp_repo/services/database.dart';
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password, String name, String phoneNumber) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserInfo(name, phoneNumber, email);

      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}