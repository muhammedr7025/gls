import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'login_screen.dart';

class SettingsStaff extends StatefulWidget {
  const SettingsStaff({Key? key}) : super(key: key);

  @override
  State<SettingsStaff> createState() => _SettingsStaffState();
}

class _SettingsStaffState extends State<SettingsStaff> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 30,
            child: Center(
              child: Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 92,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://st4.depositphotos.com/1012074/20946/v/450/depositphotos_209469984-stock-illustration-flat-isolated-vector-illustration-icon.jpg"),
            ),
          ),
          const SizedBox(
            height: 10, //just for a padding
          ),
          SizedBox(
            child: Text(
              "${loggedInUser.firstName}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          const SizedBox(
            height: 6, //just for a padding
          ),
          SizedBox(
            child: Text(
              "${loggedInUser.secondName}",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 6, //just for a padding
          ),
          SizedBox(
            child: Text(
              "${loggedInUser.email}",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 25, //just for a padding
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              children: [
                Material(
                  color: Colors.orange,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: InkWell(
                    splashColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    onTap: () {},
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.info,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "About",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.navigate_next),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  color: Colors.orange,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: InkWell(
                    splashColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      logout(context);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.logout,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.navigate_next),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
