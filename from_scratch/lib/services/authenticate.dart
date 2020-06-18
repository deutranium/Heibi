import 'package:firebase_auth/firebase_auth.dart';
import 'package:from_scratch/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authservice {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _db = Firestore.instance;
  //new user based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //anon
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      //on success
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email+pass
  Future signInWithEmail(String email, String passwd) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: passwd);
      FirebaseUser fbuser = result.user;
      return _userFromFirebaseUser(fbuser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reg
  Future regWithEmail(String email, String passwd) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      FirebaseUser fbuser = result.user;
      return _userFromFirebaseUser(fbuser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //gets user
  Future getUser() async {
    try {
      final user = await _auth.currentUser();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //google sign in
  Future signInWithGoogle() async{
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authresult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authresult.user;
    return _userFromFirebaseUser(user);
  }
}
