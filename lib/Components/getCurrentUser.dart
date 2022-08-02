import 'package:firebase_auth/firebase_auth.dart';

String getCurrentUser() {
  final _auth = FirebaseAuth.instance;
  final currentUser =  _auth.currentUser;
  if(currentUser != null){
      final user = currentUser.email;
      return user;
  }
}