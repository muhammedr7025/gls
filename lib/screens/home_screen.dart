import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/bloc/cubit/db_cubit.dart';
import 'package:email_password_login/model/db_model.dart';
import 'package:email_password_login/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  double gasLevel = 0;
  bool outflow = true;
  bool nob = true;
  DbModel? data;
  int count = 0;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    BlocProvider.of<DbCubit>(context).fetchdb();
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome"),
          centerTitle: true,
        ),
        body: BlocListener<DbCubit, DbState>(
          listener: (context, state) {
            if (state is DbLoaded) {
              data = state.db;
              if (data!.leakage == true) {
                count = 1;
              }
              setState(() {
                outflow = data!.leakage;
                gasLevel = data!.balance;
                nob = data!.nob;
              });
              print(data!.leakage == true);
              if (data!.leakage == true) {
                if (count == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Alert'),
                      content: Text('There is a gas Leakage'),
                    ),
                  );
                }
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: 10,
                        channelKey: 'basic_channel',
                        title: 'Gas Leakage',
                        body: 'Gas Leakage Detected'));
              }
              count = 2;
            }
          },
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 55.0),
                          child: Text(
                            "Gas outflow:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        outflow == false
                            ? Container(
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: 80,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Safe",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : Text(
                                "At risk",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red),
                              )
                      ],
                    ),
                  ),
                ),
                Container(
                    child: SfRadialGauge(
                        title: GaugeTitle(
                            text: 'Gas level',
                            textStyle: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: 100.001,
                          pointers: <GaugePointer>[
                            NeedlePointer(value: gasLevel)
                          ],
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 20,
                                color: Colors.red,
                                startWidth: 10,
                                endWidth: 10),
                            GaugeRange(
                                startValue: 20,
                                endValue: 50,
                                color: Colors.orange,
                                startWidth: 10,
                                endWidth: 10),
                            GaugeRange(
                                startValue: 50,
                                endValue: 100,
                                color: Colors.green,
                                startWidth: 10,
                                endWidth: 10)
                          ]),
                    ])),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    print(nob);
                    BlocProvider.of<DbCubit>(context).create(!nob);
                  },
                  child: nob ? Text('Close') : Text('Open'),
                ),
              ],
            ),
          ),
        ));
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
