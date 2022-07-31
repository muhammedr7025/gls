import 'package:email_password_login/btmnav.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  // ith statefull anne abstract classinna inheritt chayunnu
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //first working function
    checkLoggedIn(); //calling function checklogged ithh thazhaa kidappundd
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/logo.png")));
  }

  Future<void> goToWelcome() async {
    await Future.delayed(
        const Duration(seconds: 3)); // ee page 3 second delay channe
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const LoginScreen())); //welcome pagill lott pokanneee
  }

  Future<void> checkLoggedIn() async {
    final _sharedPrefs = await SharedPreferences
        .getInstance(); //shared preference inda instance edukannee
    final _loggedStatus = _sharedPrefs.getString(
        LOG_KEY); // nerathey eduthaa instance ill ninnu value edukkanne
    if (_loggedStatus == "loggedin") {
      // ahh eduthaa value check chayukka ath admin log annenkill
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx1) => BtmNav())); // adminscreenillot povukkaaa
    } else
    // ignore: unnecessary_statements
    {
      // ahh eduthaa value check chayukka ath stafflog  annenkill
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx1) => LoginScreen())); // btmnav illot povukkaaa
    }
    ;
  }
}
