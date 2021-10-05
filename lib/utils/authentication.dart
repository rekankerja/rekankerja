import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rekankerja/Class/ClassUserLogin.dart';
import 'package:rekankerja/DbLokal/DbHelper.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import '../screen/HomePage.dart';
import 'package:rekankerja/screen/userinfoscreen.dart';
import '../Global/GlobalVariable.dart';
//
// class Authentication {
//   static Future<FirebaseApp> initializeFirebase({
//     @required BuildContext context,
//   }) async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     userLogin = FirebaseAuth.instance.currentUser;
//
//     if (userLogin != null) {
//       userLogin2 = ClassUserLogin(userLogin.uid, userLogin.displayName, userLogin.email, userLogin.photoURL, userLogin.metadata.creationTime, userLogin.metadata.lastSignInTime);
//       var db = new DBHelper();
//       final responselog = await db.getUser();
//
//       if (responselog.isNotEmpty == true) {
//         //Jika data user sudah ada
//         try{
//           var userhelper = UserHelper(userLogin2.uid, userLogin2.email, userLogin2.displayName, userLogin2.lastSignInTime.toString());
//           userhelper.setUserId(1);
//           await db.updateUser(userhelper);
//         } catch(er){
//           print(er);
//         }
//
//         try{
//           Subs(); // SUBs untuk MQTT
//         }
//         catch(er){
//           print(er);
//         }
//
//       } else {
//         //Jika data user kosong
//         var userhelper = UserHelper(userLogin2.uid, userLogin2.email, userLogin2.displayName, userLogin2.lastSignInTime.toString());
//         await db.saveUser(userhelper);
//       }
//
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               MyHomePage(
//                 user: userLogin,
//
//               ),
//         ),
//       );
//     }
//
//     return firebaseApp;
//   }
// }