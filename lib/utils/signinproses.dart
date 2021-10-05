

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rekankerja/Class/ClassUserLogin.dart';
import 'package:rekankerja/DbLokal/DbHelper.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';

import '../Global/GlobalVariable.dart';

// class AuthenticationSignIn {
//   static Future<User> signInWithGoogle({@required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User user;
//
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     final GoogleSignInAccount googleSignInAccount =
//     await googleSignIn.signIn();
//
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       try {
//         var db = new DBHelper();
//         final UserCredential userCredential =
//         await auth.signInWithCredential(credential);
//         userLogin = userCredential.user;
//
//        // print(userLogin);
//         userLogin2 = ClassUserLogin(userLogin.uid, userLogin.displayName, userLogin.email, userLogin.photoURL, userLogin.metadata.creationTime, userLogin.metadata.lastSignInTime);
//         //print("User Login2 : ${userLogin2.uid} ${userLogin2.displayName} ${userLogin2.email} ${userLogin2.photoURL} ${userLogin2.createDate} ${userLogin2.lastSignInTime}");
//
//         final responselog = await db.getUser();
//
//         if (responselog.isNotEmpty == true) {
//           //Jika data user sudah ada
//           var userhelper = UserHelper(userLogin2.uid, userLogin2.email, userLogin2.displayName, userLogin2.lastSignInTime.toString());
//
//           userhelper.setUserId(1);
//           await db.updateUser(userhelper);
//
//         } else {
//           //Jika data user kosong
//           try{
//             var userhelper = UserHelper(userLogin2.uid, userLogin2.email, userLogin2.displayName, userLogin2.lastSignInTime.toString());
//             await db.saveUser(userhelper);
//           } catch(er){
//             print(er);
//           }
//         }
//         try{
//           Subs(); // SUBs untuk MQTT
//         }
//         catch(er){
//           print(er);
//         }
//
//
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // handle the error here
//         }
//         else if (e.code == 'invalid-credential') {
//           // handle the error here
//         }
//       } catch (e) {
//         print(e);
//         // handle the error here
//       }
//     }
//
//     return userLogin;
//   }
// }