import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:ntp/ntp.dart';
import 'package:rekankerja/Class/ClassRekanKerja.dart';
import 'package:rekankerja/Class/ClassSettingAdmin.dart';
import 'package:rekankerja/Class/ClassUserLogin.dart';
import 'package:rekankerja/DbLokal/DbHelper.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/screen/HomePage.dart';
import 'package:http/http.dart' as http;
import 'GlobalFunctionListenSubsMQTT.dart';
import 'GlobalFunctionPublishMQTT.dart';
import 'GlobalVariable.dart';

Future<int> Subs() async {
  /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
  /// for details.
  /// To use websockets add the following lines -:
  /// client.useWebSocket = true;
  /// client.port = 80;  ( or whatever your WS port is)
  /// There is also an alternate websocket implementation for specialist use, see useAlternateWebSocketImplementation
  /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.
  /// You can also supply your own websocket protocol list or disable this feature using the websocketProtocols
  /// setter, read the API docs for further details here, the vast majority of brokers will support the client default
  /// list so in most cases you can ignore this.
  /// Set logging on if needed, defaults to off
  client.logging(on: false);

  /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
  //client.keepAlivePeriod = 5;

  /// Set auto reconnect
  client.autoReconnect = true;

  /// If you do not want active confirmed subscriptions to be automatically re subscribed
  /// by the auto connect sequence do the following, otherwise leave this defaulted.
  client.resubscribeOnAutoReconnect = true;

  /// Add an auto reconnect callback.
  /// This is the 'pre' auto re connect callback, called before the sequence starts.
  client.onAutoReconnect = onAutoReconnect;

  /// Add an auto reconnect callback.
  /// This is the 'post' auto re connect callback, called after the sequence
  /// has completed. Note that re subscriptions may be occurring when this callback
  /// is invoked. See [resubscribeOnAutoReconnect] above.
  client.onAutoReconnected = onAutoReconnected;

  /// Add the successful connection callback if you need one.
  /// This will be called after [onAutoReconnect] but before [onAutoReconnected]
  client.onConnected = onConnected;

  /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  /// You can add these before connection or change them dynamically after connection if
  /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  /// can fail either because you have tried to subscribe to an invalid topic or the broker
  /// rejects the subscribe request.
  client.onSubscribed = onSubscribed;

  /// Set a ping received callback if needed, called whenever a ping response(pong) is received
  /// from the broker.
  client.pongCallback = pong;

  /// Create a connection message to use or use the default one. The default one sets the
  /// client identifier, any supplied username/password and clean session,
  /// an example of a specific one below.
  final connMess = MqttConnectMessage()
      .withClientIdentifier(userLogin2.uid)
      .authenticateAs("jkaisssy:jkaisssy",
          "MjXKWcUC13vDT6WnWlKyK7I8v_sPXtTV") // additional code when connecting to a broker w/ creds
      // .withWillTopic('willtopic') // If you set this you must set a will message
      // .withWillMessage('My Will message')
      //.startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;

  /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  /// never send malformed messages.
  try {
    await client.connect();
    isMqttConnect = true;
  } on Exception catch (e) {
    isMqttConnect = false;
    print('client exception - $e');
    client.disconnect();
  }

  /// Check we are connected
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    // print('Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    // print(
    //     'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
  }

  /// Ok, lets try a subscription

  client.subscribe(topic1, MqttQos.atMostOnce);
  client.subscribe(topic2, MqttQos.atMostOnce);
  client.subscribe(topic3, MqttQos.atMostOnce);
  client.subscribe(topic4, MqttQos.atMostOnce);
  client.subscribe(topic6, MqttQos.atMostOnce);

  /// The client has a change notifier object(see the Observable class) which we then listen to to get
  /// notifications of published updates to each subscribed topic.
  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final recMess = c[0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    if (c[0].topic.startsWith("RekanKerjaSetting/${userLogin2.referall}")) {
      ListenSettingAdmin(pt);
    } else if (c[0].topic.startsWith("RekanKerja/${userLogin2.referall}")) {
      ListenRekanKerja(pt);
    } else if (c[0]
        .topic
        .startsWith("RekanKerjaJabatan/${userLogin2.referall}")) {
      ListenRekanKerjaJabatan(pt);
    } else if (c[0]
        .topic
        .startsWith("RekanKerjaBuzzer/${userLogin2.referall}")) {
      ListenRekanKerjaBuzzer(pt);
    }

    // print(
    //     'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    // print('');
  });

  /// If needed you can listen for published messages that have completed the publishing
  /// handshake which is Qos dependant. Any message received on this stream has completed its
  /// publishing handshake with the broker.
  // client.published.listen((MqttPublishMessage message) {
  //   print(
  //       'Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  // });

  /// Lets publish to our topic
  /// Use the payload builder rather than a raw buffer
  /// Our known topic to publish to
  // const pubTopic = 'Dart/Mqtt_client/testtopic';
  // final builder = MqttClientPayloadBuilder();
  //builder.addString('Hello from mqtt_client');

  /// Subscribe to it
  // print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  // client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// Publish it
  // print('EXAMPLE::Publishing our topic');
  // client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  /// Ok, we will now sleep a while, in this gap you will see ping request/response
  /// messages being exchanged by the keep alive mechanism.
  // print('EXAMPLE::Sleeping....');
  //await MqttUtilities.asyncSleep(120);

  /// Finally, unsubscribe and exit gracefully
  //print('EXAMPLE::Unsubscribing');
  //client.unsubscribe(topic);

  /// Wait for the unsubscribe message from the broker if you wish.
  //await MqttUtilities.asyncSleep(2);
  //print('EXAMPLE::Disconnecting');
  //client.disconnect();
  return 0;
}

UnSubs() async {
  print('EXAMPLE::Unsubscribing');
  client.unsubscribe(topic1);
  client.unsubscribe(topic2);
  client.unsubscribe(topic3);
  client.unsubscribe(topic4);
  client.unsubscribe(topic6);

  pubtopic1 = 'RekanKerjaSetting/${userLogin2.referall}/${userLogin2.uid}';

  /// PUBLISH ADMIN REKAN KERJA
  pubtopic2 = 'RekanKerja/${userLogin2.referall}/${userLogin2.uid}';

  /// PUBLISH DATA REKAN KERJA
  pubtopic3 = 'RekanKerjaBuzzer/${userLogin2.referall}/${userLogin2.uid}';

  /// PUBLISH DATA BUZZER
  pubtopic4 = 'RekanKerjaBuzzerReport/${userLogin2.referall}/${userLogin2.uid}';

  /// PUBLISH DATA BUZZER REPORT
  pubtopic5 = 'RekanKerjaJabatan/${userLogin2.referall}/${userLogin2.uid}';

  /// PUBLISH DATA BUZZER REPORT
  client.disconnect();
}

/// The subscribed callback
void onSubscribed(String topic) {
  // print('Subscription confirmed for topic $topic');
}

/// The pre auto re connect callback
void onAutoReconnect() {
  // print(
  //     'onAutoReconnect client callback - Client auto reconnection sequence will start');
}

/// The post auto re connect callback
void onAutoReconnected() {
  // print(
  //     'onAutoReconnected client callback - Client auto reconnection sequence has completed');
}

/// The successful connect callback
void onConnected() {
  // print('OnConnected client callback - Client connection was successful');
}

/// Pong callback
void pong() {
  // print(
  //     'Ping response client callback invoked - you may want to disconnect your broker here');
}

class AuthenticationSignIn {
  static Future<User> signInWithGoogle({@required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final responselog = await db.getUser();

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        userLogin = userCredential.user;

        // print(userLogin);
        //userLogin2 = ClassUserLogin(userLogin.uid, userLogin.displayName, userLogin.email, userLogin.photoURL, userLogin.metadata.creationTime, userLogin.metadata.lastSignInTime, "${responselog[0].jabatan}", "${responselog[0].referall}", "${responselog[0].isNotifOn}");
        //print("User Login2 : ${userLogin2.uid} ${userLogin2.displayName} ${userLogin2.email} ${userLogin2.photoURL} ${userLogin2.createDate} ${userLogin2.lastSignInTime}");

        if (responselog.isNotEmpty == true) {
          bool isSudahAda;
          for (int _i = 0; _i < responselog.length; _i++) {
            /// PENGUJIAN UNTUK APAKAH USER SUDAH PERNAH LOGIN LALU LOGOUT
            if (responselog[_i].uid == userLogin.uid) {
              isSudahAda = true;
              urutanDBLokalUserLogin = _i;
              break;
            }
            isSudahAda = false;
          }

          if (!isSudahAda) {
            /// BILA USER BELUM ADA
            urutanDBLokalUserLogin = responselog.length - 1;
            var userhelper = UserHelper(
                userLogin.uid,
                userLogin.email,
                userLogin.displayName,
                userLogin.photoURL,
                userLogin.metadata.lastSignInTime.toString(),
                "ADMIN",
                "${userLogin.uid.substring(0, 5)}",
                "${userLogin.uid.substring(0, 5)}",
                "TRUE",
                "AKTIF",
                "",
                null,
                null,
                "FALSE",
                null,
                null,
                "FALSE",
                "FALSE",
                "$appVersion",
                "$buildCode");
            await db.saveUser(userhelper);
            userLogin2 = ClassUserLogin(
                userLogin.uid,
                userLogin.displayName,
                userLogin.email,
                userLogin.photoURL,
                userLogin.metadata.creationTime.toString(),
                userLogin.metadata.lastSignInTime.toString(),
                "ADMIN",
                "${userLogin.uid.substring(0, 5)}",
                "${userLogin.uid.substring(0, 5)}",
                "TRUE",
                "AKTIF",
                "",
                null,
                null,
                "FALSE",
                null,
                null,
                "FALSE",
                "FALSE");

            try {
              // await Future.delayed(const Duration(milliseconds: 250), () {
              //   Subs();
              // }); // SUBs untuk MQTT
              Subs();
            } catch (er) {
              print(er);
            }
          } else {
            /// BILA USER SUDAH ADA DI DB

            var userhelper = UserHelper(
                responselog[urutanDBLokalUserLogin].uid,
                responselog[urutanDBLokalUserLogin].email,
                responselog[urutanDBLokalUserLogin].displayName,
                responselog[urutanDBLokalUserLogin].urlPhoto,
                responselog[urutanDBLokalUserLogin].lastLogin,
                responselog[urutanDBLokalUserLogin].jabatan,
                responselog[urutanDBLokalUserLogin].referall,
                responselog[urutanDBLokalUserLogin].selfReferall,
                responselog[urutanDBLokalUserLogin].isNotifOn,
                responselog[urutanDBLokalUserLogin].workStatus,
                responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
                responselog[urutanDBLokalUserLogin].latitude,
                responselog[urutanDBLokalUserLogin].longitude,
                "FALSE",
                responselog[urutanDBLokalUserLogin].alatAddress,
                responselog[urutanDBLokalUserLogin].alatNama,
                responselog[urutanDBLokalUserLogin].isMotion,
                responselog[urutanDBLokalUserLogin].isImage,
                "$appVersion",
                "$buildCode");
            userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
            await db.updateUser(userhelper);


            userLogin2 = ClassUserLogin(
              userLogin.uid,
              userLogin.displayName,
              userLogin.email,
              userLogin.photoURL,
              userLogin.metadata.creationTime.toString(),
              userLogin.metadata.lastSignInTime.toString(),
              "${responselog[urutanDBLokalUserLogin].jabatan}",
              "${responselog[urutanDBLokalUserLogin].referall}",
              "${responselog[urutanDBLokalUserLogin].selfReferall}",
              "${responselog[urutanDBLokalUserLogin].isNotifOn}",
              "${responselog[urutanDBLokalUserLogin].workStatus}",
              "${responselog[urutanDBLokalUserLogin].keteranganWorkStatus}",
              "${responselog[urutanDBLokalUserLogin].latitude}",
              "${responselog[urutanDBLokalUserLogin].longitude}",
              "FALSE",
              "${responselog[urutanDBLokalUserLogin].alatAddress}",
              "${responselog[urutanDBLokalUserLogin].alatNama}",
              responselog[urutanDBLokalUserLogin].isMotion,
              responselog[urutanDBLokalUserLogin].isImage,
            );

            // try {
            //   /// GET DATA UNTUK USER REKAN KERJA
            //   final responselogrekankerja = await db.getRekanKerja();
            //   rekanKerja.clear(); // Kosongkan dahulu
            //   for (int _i = 0; _i < responselogrekankerja.length; _i++) {
            //     rekanKerja.add(ClassRekanKerja(
            //         responselogrekankerja[_i].uid,
            //         responselogrekankerja[_i].displayName,
            //         responselogrekankerja[_i].email,
            //         responselogrekankerja[_i].urlPhoto,
            //         responselogrekankerja[_i].jabatan,
            //         null,
            //         responselogrekankerja[_i].lastLogin,
            //         null,
            //         null,
            //         responselogrekankerja[_i].isNotifOn,
            //         responselogrekankerja[_i].workStatus,
            //         responselogrekankerja[_i].keteranganWorkStatus,
            //         responselogrekankerja[_i].latitude,
            //         responselogrekankerja[_i].longitude,
            //         responselogrekankerja[_i].lastUpdate));
            //   }
            // } catch (er) {
            //   print(er);
            // }
          }
          //Jika data user sudah ada
          // var userhelper = UserHelper(userLogin.uid, userLogin.email, userLogin.displayName, userLogin.metadata.lastSignInTime.toString(), "${responselog[0].jabatan}", "${responselog[0].referall}", "${responselog[0].selfReferall}", "${responselog[0].isNotifOn}", "$appVersion", "$buildCode");
          // userhelper.setUserId(1);
          // await db.updateUser(userhelper);

        } else {
          /// JIKA TABEL USER BELUM ADA ISINYA
          try {
            urutanDBLokalUserLogin = 0;
            var userhelper = UserHelper(
                userLogin.uid,
                userLogin.email,
                userLogin.displayName,
                userLogin.photoURL,
                userLogin.metadata.lastSignInTime.toString(),
                "ADMIN",
                "${userLogin.uid.substring(0, 5)}",
                "${userLogin.uid.substring(0, 5)}",
                "TRUE",
                "AKTIF",
                "",
                null,
                null,
                "FALSE",
                null,
                null,
                "FALSE",
                "FALSE",
                "$appVersion",
                "$buildCode");
            await db.saveUser(userhelper);
            userLogin2 = ClassUserLogin(
                userLogin.uid,
                userLogin.displayName,
                userLogin.email,
                userLogin.photoURL,
                userLogin.metadata.creationTime.toString(),
                userLogin.metadata.lastSignInTime.toString(),
                "${responselog[0].jabatan}",
                "${responselog[0].referall}",
                "${responselog[0].selfReferall}",
                "${responselog[0].isNotifOn}",
                "${responselog[0].workStatus}",
                "${responselog[0].keteranganWorkStatus}",
                null,
                null,
                "FALSE",
                null,
                null,
                "FALSE",
                "FALSE");

            try {
              // await Future.delayed(const Duration(milliseconds: 250), () {
              //   Subs();
              // }); // SUBs untuk MQTT
              Subs();
            } catch (er) {
              print(er);
            }
          } catch (er) {
            print(er);
          }
        }

        final isitabelsetting = await db.getSettingAdmin();

        if (isitabelsetting.isEmpty) {
          var _settinghelper =
              SettingAdmin("HARI KERJA", "SENIN", "08:00", "17:00", "TRUE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "SELASA", "08:00", "17:00", "TRUE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "RABU", "08:00", "17:00", "TRUE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "KAMIS", "08:00", "17:00", "TRUE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "JUMAT", "08:00", "17:00", "TRUE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "SABTU", null, null, "FALSE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper =
              SettingAdmin("HARI KERJA", "MINGGU", null, null, "FALSE");
          await db.saveSettingAdmin(_settinghelper);
          _settinghelper = SettingAdmin("REFRESH RATE", "5", null, null, null);
          await db.saveSettingAdmin(_settinghelper);
        }

        getDataFromDatabaseLokalAfterLogin(); // Ambil isi dari Database Lokal

      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        print(e);
        // handle the error here
      }
    }
    return userLogin;
  }
}

class Authentication {
  static Future<FirebaseApp> initializeFirebase({
    @required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    userLogin = FirebaseAuth.instance.currentUser;

    if (userLogin != null) {
      final responselog = await db.getUser();
      final responselogrekankerja = await db.getRekanKerja();

      //userLogin2 = ClassUserLogin(userLogin.uid, userLogin.displayName, userLogin.email, userLogin.photoURL, userLogin.metadata.creationTime, userLogin.metadata.lastSignInTime, "${responselog[0].jabatan}", "${responselog[0].referall}", "${responselog[0].isNotifOn}");

      if (responselog.isNotEmpty == true) {
        bool isSudahAda;
        for (int _i = 0; _i < responselog.length; _i++) {
          /// PENGUJIAN UNTUK APAKAH USER SUDAH PERNAH LOGIN LALU LOGOUT
          if (responselog[_i].uid == userLogin.uid) {
            isSudahAda = true;
            urutanDBLokalUserLogin = _i;
            break;
          }
          isSudahAda = false;
        }

        if (!isSudahAda) {
          /// BILA USER BELUM ADA
          urutanDBLokalUserLogin = responselog.length - 1;
          var userhelper = UserHelper(
              userLogin.uid,
              userLogin.email,
              userLogin.displayName,
              userLogin.photoURL,
              userLogin.metadata.lastSignInTime.toString(),
              "ADMIN",
              "${userLogin.uid.substring(0, 5)}",
              "${userLogin.uid.substring(0, 5)}",
              "TRUE",
              "AKTIF",
              "",
              null,
              null,
              "FALSE",
              null,
              null,
              "FALSE",
              "FALSE",
              "$appVersion",
              "$buildCode");
          await db.saveUser(userhelper);
          userLogin2 = ClassUserLogin(
              userLogin.uid,
              userLogin.displayName,
              userLogin.email,
              userLogin.photoURL,
              userLogin.metadata.creationTime.toString(),
              userLogin.metadata.lastSignInTime.toString(),
              "ADMIN",
              "${userLogin.uid.substring(0, 5)}",
              "${userLogin.uid.substring(0, 5)}",
              "TRUE",
              "AKTIF",
              "",
              null,
              null,
              "FALSE",
              null,
              null,
              "FALSE",
              "FALSE");
        } else {
          /// BILA USER SUDAH ADA DI DB
          try{
            /// UPDATE DB SUPAYA ALAT GAK KONEK DAHULU UNTUK INFO KE REKAN KERJA LAIN

            //final responselog = await db.getUser();
            var userhelper = UserHelper(
                responselog[urutanDBLokalUserLogin].uid,
                responselog[urutanDBLokalUserLogin].email,
                responselog[urutanDBLokalUserLogin].displayName,
                responselog[urutanDBLokalUserLogin].urlPhoto,
                responselog[urutanDBLokalUserLogin].lastLogin,
                responselog[urutanDBLokalUserLogin].jabatan,
                responselog[urutanDBLokalUserLogin].referall,
                responselog[urutanDBLokalUserLogin].selfReferall,
                responselog[urutanDBLokalUserLogin].isNotifOn,
                responselog[urutanDBLokalUserLogin].workStatus,
                responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
                responselog[urutanDBLokalUserLogin].latitude,
                responselog[urutanDBLokalUserLogin].longitude,
                "FALSE",
                responselog[urutanDBLokalUserLogin].alatAddress,
                responselog[urutanDBLokalUserLogin].alatNama,
                responselog[urutanDBLokalUserLogin].isMotion,
                responselog[urutanDBLokalUserLogin].isImage,
                "$appVersion",
                "$buildCode");
            userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
            await db.updateUser(userhelper);


            userLogin2 = ClassUserLogin(
              userLogin.uid,
              userLogin.displayName,
              userLogin.email,
              userLogin.photoURL,
              userLogin.metadata.creationTime.toString(),
              userLogin.metadata.lastSignInTime.toString(),
              "${responselog[urutanDBLokalUserLogin].jabatan}",
              "${responselog[urutanDBLokalUserLogin].referall}",
              "${responselog[urutanDBLokalUserLogin].selfReferall}",
              "${responselog[urutanDBLokalUserLogin].isNotifOn}",
              "${responselog[urutanDBLokalUserLogin].workStatus}",
              "${responselog[urutanDBLokalUserLogin].keteranganWorkStatus}",
              "${responselog[urutanDBLokalUserLogin].latitude}",
              "${responselog[urutanDBLokalUserLogin].longitude}",
              "FALSE",
              "${responselog[urutanDBLokalUserLogin].alatAddress}",
              "${responselog[urutanDBLokalUserLogin].alatNama}",
                "${responselog[urutanDBLokalUserLogin].isMotion}",
                "${responselog[urutanDBLokalUserLogin].isImage}"
            );
          } catch(er){
            print(er);
          }

          // try {
          //   /// GET DATA UNTUK USER REKAN KERJA
          //
          //   rekanKerja.clear(); // Kosongkan dahulu
          //   for (int _i = 0; _i < responselogrekankerja.length; _i++) {
          //     rekanKerja.add(ClassRekanKerja(
          //         responselogrekankerja[_i].uid,
          //         responselogrekankerja[_i].displayName,
          //         responselogrekankerja[_i].email,
          //         responselogrekankerja[_i].urlPhoto,
          //         responselogrekankerja[_i].jabatan,
          //         null,
          //         responselogrekankerja[_i].lastLogin,
          //         null,
          //         null,
          //         responselogrekankerja[_i].isNotifOn,
          //         responselogrekankerja[_i].workStatus,
          //         responselogrekankerja[_i].keteranganWorkStatus,
          //         responselogrekankerja[_i].latitude,
          //         responselogrekankerja[_i].longitude,
          //         responselogrekankerja[_i].lastUpdate));
          //   }
          // } catch (er) {
          //   print(er);
          // }
        }
        try {
          // await Future.delayed(const Duration(milliseconds: 250), () {
          //   Subs();
          // }); // SUBs untuk MQTT
          Subs();
        } catch (er) {
          print(er);
        }
        //Jika data user sudah ada
        // var userhelper = UserHelper(userLogin.uid, userLogin.email, userLogin.displayName, userLogin.metadata.lastSignInTime.toString(), "${responselog[0].jabatan}", "${responselog[0].referall}", "${responselog[0].selfReferall}", "${responselog[0].isNotifOn}", "$appVersion", "$buildCode");
        // userhelper.setUserId(1);
        // await db.updateUser(userhelper);

      } else {
        /// JIKA TABEL USER BELUM ADA ISINYA
        try {
          urutanDBLokalUserLogin = 0;
          var userhelper = UserHelper(
              userLogin.uid,
              userLogin.email,
              userLogin.displayName,
              userLogin.photoURL,
              userLogin.metadata.lastSignInTime.toString(),
              "ADMIN",
              "${userLogin.uid.substring(0, 5)}",
              "${userLogin.uid.substring(0, 5)}",
              "TRUE",
              "AKTIF",
              "",
              null,
              null,
              "FALSE",
              null,
              null,
              'FALSE',
              "FALSE",
              "$appVersion",
              "$buildCode");
          await db.saveUser(userhelper);
          userLogin2 = ClassUserLogin(
              userLogin.uid,
              userLogin.displayName,
              userLogin.email,
              userLogin.photoURL,
              userLogin.metadata.creationTime.toString(),
              userLogin.metadata.lastSignInTime.toString(),
              "${responselog[0].jabatan}",
              "${responselog[0].referall}",
              "${responselog[0].selfReferall}",
              "${responselog[0].isNotifOn}",
              "${responselog[0].workStatus}",
              "${responselog[0].keteranganWorkStatus}",
              null,
              null,
              "FALSE",
              null,
              null,
              'FALSE',
              "FALSE");
        } catch (er) {
          print(er);
        }
      }

      getDataFromDatabaseLokalAfterLogin(); // Ambil isi dari Database Lokal

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            user: userLogin,
          ),
        ),
      );
    }
    return firebaseApp;
  }
}

getDataFromDatabaseLokalAfterLogin() async {
  final isitabelsetting = await db.getSettingAdmin();

  refreshRate = ClassSettingAdmin(
      isitabelsetting[7].setting,
      isitabelsetting[7].attribut1,
      isitabelsetting[7].attribut2,
      isitabelsetting[7].attribut3,
      isitabelsetting[7].attribut4);
}

Future<String> SetReferall(referall) async {
  try {
    final responselog = await db.getUser();

    //print(urutanDBLokalUserLogin);

    var userhelper = UserHelper(
        responselog[urutanDBLokalUserLogin].uid,
        responselog[urutanDBLokalUserLogin].email,
        responselog[urutanDBLokalUserLogin].displayName,
        responselog[urutanDBLokalUserLogin].urlPhoto,
        responselog[urutanDBLokalUserLogin].lastLogin,
        userLogin2.selfReferall == referall ? "ADMIN" : "USER",
        "$referall",
        responselog[urutanDBLokalUserLogin].selfReferall,
        responselog[urutanDBLokalUserLogin].isNotifOn,
        responselog[urutanDBLokalUserLogin].workStatus,
        responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
        responselog[urutanDBLokalUserLogin].latitude,
        responselog[urutanDBLokalUserLogin].longitude,
        responselog[urutanDBLokalUserLogin].alatConnect,
        responselog[urutanDBLokalUserLogin].alatAddress,
        responselog[urutanDBLokalUserLogin].alatNama,
        (responselog[urutanDBLokalUserLogin].isMotion),
        (responselog[urutanDBLokalUserLogin].isImage),
        "$appVersion",
        "$buildCode");
    userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
    await db.updateUser(userhelper);
    userLogin2.referall = referall; // UPDATE untuk userLogin
    userLogin2.jabatan = userLogin2.selfReferall == referall
        ? "ADMIN"
        : "USER"; // Update untuk userlogin menjadi jabatan ADMIN

    topic1 = 'RekanKerja/${userLogin2.referall}/#';

    /// LIST GLOBAL REKAN KERJA
    topic2 = 'RekanKerjaDetail/${userLogin2.referall}/#';

    /// DETAIL REKAN KERJA
    topic3 = 'RekanKerjaBuzzer/${userLogin2.referall}/#';

    /// BUZZER REKAN KERJA
    topic4 = 'RekanKerjaSetting/${userLogin2.referall}/#';

    /// SETTINGAN ADMIN REKAN KERJA

    UnSubs();
    Subs();
    return "sukses";
  } catch (er) {
    print(er);
    return "gagal";
  }
}

Future<String> SetStatusKerja(status) async {
  try {
    final responselog = await db.getUser();
    var userhelper = UserHelper(
        responselog[urutanDBLokalUserLogin].uid,
        responselog[urutanDBLokalUserLogin].email,
        responselog[urutanDBLokalUserLogin].displayName,
        responselog[urutanDBLokalUserLogin].urlPhoto,
        responselog[urutanDBLokalUserLogin].lastLogin,
        responselog[urutanDBLokalUserLogin].jabatan,
        responselog[urutanDBLokalUserLogin].referall,
        responselog[urutanDBLokalUserLogin].selfReferall,
        responselog[urutanDBLokalUserLogin].isNotifOn,
        "$status",
        responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
        responselog[urutanDBLokalUserLogin].latitude,
        responselog[urutanDBLokalUserLogin].longitude,
        responselog[urutanDBLokalUserLogin].alatConnect,
        responselog[urutanDBLokalUserLogin].alatAddress,
        responselog[urutanDBLokalUserLogin].alatNama,
        responselog[urutanDBLokalUserLogin].isMotion,
        responselog[urutanDBLokalUserLogin].isImage,
        "$appVersion",
        "$buildCode");
    userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
    await db.updateUser(userhelper);
    userLogin2.workStatus = status; // UPDATE untuk workstatus
    return "sukses";
  } catch (er) {
    print(er);
    return "gagal";
  }
}

Future<String> SetAlatConnect(alatConnect, alatAddress, alatNama) async {
  try {
    userLogin2.alatConnect = alatConnect; // UPDATE untuk alatConnect
    userLogin2.alatAddress = alatAddress; // UPDATE untuk alatConnect
    userLogin2.alatNama = alatNama; // UPDATE untuk alatConnect

    final responselog = await db.getUser();
    var userhelper = UserHelper(
        responselog[urutanDBLokalUserLogin].uid,
        responselog[urutanDBLokalUserLogin].email,
        responselog[urutanDBLokalUserLogin].displayName,
        responselog[urutanDBLokalUserLogin].urlPhoto,
        responselog[urutanDBLokalUserLogin].lastLogin,
        responselog[urutanDBLokalUserLogin].jabatan,
        responselog[urutanDBLokalUserLogin].referall,
        responselog[urutanDBLokalUserLogin].selfReferall,
        responselog[urutanDBLokalUserLogin].isNotifOn,
        responselog[urutanDBLokalUserLogin].workStatus,
        responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
        responselog[urutanDBLokalUserLogin].latitude,
        responselog[urutanDBLokalUserLogin].longitude,
        "$alatConnect",
        "$alatAddress",
        "$alatNama",
        responselog[urutanDBLokalUserLogin].isMotion,
        responselog[urutanDBLokalUserLogin].isImage,
        "$appVersion",
        "$buildCode");
    userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
    await db.updateUser(userhelper);

    return "sukses";
  } catch (er) {
    print(er);
    return "gagal";
  }
}

Future<String> SetJanganGanggu(isJanganGanggu) async {
  try {
    final responselog = await db.getUser();
    var userhelper = UserHelper(
        responselog[urutanDBLokalUserLogin].uid,
        responselog[urutanDBLokalUserLogin].email,
        responselog[urutanDBLokalUserLogin].displayName,
        responselog[urutanDBLokalUserLogin].urlPhoto,
        responselog[urutanDBLokalUserLogin].lastLogin,
        responselog[urutanDBLokalUserLogin].jabatan,
        responselog[urutanDBLokalUserLogin].referall,
        responselog[urutanDBLokalUserLogin].selfReferall,
        "$isJanganGanggu",
        responselog[urutanDBLokalUserLogin].workStatus,
        responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
        responselog[urutanDBLokalUserLogin].latitude,
        responselog[urutanDBLokalUserLogin].longitude,
        responselog[urutanDBLokalUserLogin].alatConnect,
        responselog[urutanDBLokalUserLogin].alatAddress,
        responselog[urutanDBLokalUserLogin].alatNama,
        responselog[urutanDBLokalUserLogin].isMotion,
        responselog[urutanDBLokalUserLogin].isImage,
        "$appVersion",
        "$buildCode");
    userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
    await db.updateUser(userhelper);
    userLogin2.isNotifOn = isJanganGanggu; // UPDATE untuk userLogin2 isNotifOn

    return "sukses";
  } catch (er) {
    print(er);
    return "gagal";
  }
}

Future<String> SetHariKerja(List settingHariKerja) async {
  try {
    for (int _i = 0; _i < settingHariKerja.length; _i++) {
      var _settinghelper = SettingAdmin(
          settingHariKerja[_i].setting,
          settingHariKerja[_i].attribut1,
          settingHariKerja[_i].attribut2,
          settingHariKerja[_i].attribut3,
          settingHariKerja[_i].attribut4);
      _settinghelper.setSettingId(_i + 1); // +1 UNTUK SESUAIKAN DENGAN ID
      await db.updateSettingAdmin(_settinghelper);
    }

    PublishData();

    return "sukses";
  } catch (er) {
    return "gagal";
  }
}

Future<String> SetRefreshRate(refreshrate) async {
  try {
    final responselog = await db.getSettingAdminRefreshRate();
    var settingAdmin = SettingAdmin(
        responselog[0].setting,
        refreshrate,
        responselog[0].attribut2,
        responselog[0].attribut3,
        responselog[0].attribut4);
    settingAdmin.setSettingId(8);
    await db.updateSettingAdmin(settingAdmin);
    refreshRate.attribut1 = refreshrate;
    PublishData();
  } catch (er) {
    print(er);
  }
}

TimerPublishSettingAdmin() async {
  final isitabelsetting = await db.getSettingAdmin();

  refreshRate = ClassSettingAdmin(
      isitabelsetting[7].setting,
          isitabelsetting[7].attribut1,
      isitabelsetting[7].attribut2,
      isitabelsetting[7].attribut3,
      isitabelsetting[7].attribut4);

  timer = Timer.periodic(Duration(seconds: int.parse("10")),
      (Timer t) {
    //print(refreshRate.attribut1);
    PublishData();
  });
}

TestForeGround() async {
  // Map<String, dynamic> backlogBody = new Map<String, dynamic>();
  // backlogBody['PerusahaanId'] = '3';
  // backlogBody['PerusahaanGuid'] = 'b085b8ab-0cd7-4197-9943-fcb0cf12d4d3';
  // backlogBody['IdBacklog'] = '1';
  // backlogBody['AuthenId'] = '19';
  //
  // http.Response response =
  //     await http.post(Uri.parse("http://monstercode.ip-dynamic.com:8082/Odata/TransProjectBacklogV2/DeleteBacklog"),
  //     headers: {
  //       "Accept": "Application/x-www-form-urlencoded",
  //       "Authorization": "Bearer "
  //     },
  //     body: backlogBody);
  // if (response.statusCode == 200) {
  //   print("true");
  //   return true;
  // } else {
  //   print(response.statusCode);
  //   print("false");
  //   return false;
  // }
}

PublishData() async {
  final isitabelsetting = await db.getSettingAdmin();
  final isitabeluser = await db.getUser();
  List<ClassSettingAdmin> dataSettingAdmin = [];
  List<ClassRekanKerja> dataUserLogin = [];

  DateTime date = await NTP.now();

  try {
    for (int _i = 0; _i < 8; _i++) {
      dataSettingAdmin.add(ClassSettingAdmin(
          isitabelsetting[_i].setting,
          isitabelsetting[_i].attribut1,
          isitabelsetting[_i].attribut2,
          isitabelsetting[_i].attribut3,
          isitabelsetting[_i].attribut4));
    }
    dataUserLogin.add(ClassRekanKerja(
        isitabeluser[0].uid,
        isitabeluser[0].displayName,
        isitabeluser[0].email,
        isitabeluser[0].urlPhoto,
        null,
        isitabeluser[0].lastLogin,
        isitabeluser[0].jabatan,
        isitabeluser[0].referall,
        isitabeluser[0].selfReferall,
        isitabeluser[0].isNotifOn,
        isitabeluser[0].workStatus,
        isitabeluser[0].keteranganWorkStatus,
        isitabeluser[0].alatConnect,
        isitabeluser[0].isImage,
        isitabeluser[0].isMotion,
        isitabeluser[0].latitude,
        isitabeluser[0].longitude,
        date.toString()));
    if (isitabeluser[0].jabatan == "ADMIN") {
      PublishSettingAdmin(json.encode(dataSettingAdmin));
    }
    PublishRekanKerja(json.encode(dataUserLogin));
  } catch (er) {
    print(er);
  }
}

SetGPS(latitude, longitude) async {
  /// UPDATE CLASS USER LOGIN2
  userLogin2.latitude = latitude;
  userLogin2.longitude = longitude;

  /// UPDATE KE DATABASE
  final responselog = await db.getUser();
  var userhelper = UserHelper(
      responselog[urutanDBLokalUserLogin].uid,
      responselog[urutanDBLokalUserLogin].email,
      responselog[urutanDBLokalUserLogin].displayName,
      responselog[urutanDBLokalUserLogin].urlPhoto,
      responselog[urutanDBLokalUserLogin].lastLogin,
      responselog[urutanDBLokalUserLogin].jabatan,
      responselog[urutanDBLokalUserLogin].referall,
      responselog[urutanDBLokalUserLogin].selfReferall,
      responselog[urutanDBLokalUserLogin].isNotifOn,
      responselog[urutanDBLokalUserLogin].workStatus,
      responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
      latitude,
      longitude,
      responselog[urutanDBLokalUserLogin].alatConnect,
      responselog[urutanDBLokalUserLogin].alatAddress,
      responselog[urutanDBLokalUserLogin].alatNama,
      responselog[urutanDBLokalUserLogin].isMotion,
      responselog[urutanDBLokalUserLogin].isImage,
      "$appVersion",
      "$buildCode");
  userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
  await db.updateUser(userhelper);
}
