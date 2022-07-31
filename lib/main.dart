import 'dart:developer';

import 'package:email_password_login/bloc/cubit/db_cubit.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:email_password_login/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const LOG_KEY = 'loggedin';
Future<void> _firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'GLS',
  'GLS',
  description: 'gls Notification Channel',
  importance: Importance.high,
  enableVibration: true,
  showBadge: true,
  enableLights: true,
  playSound: true,
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DbCubit(),
      child: MaterialApp(
        title: 'Email And Password Login',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
