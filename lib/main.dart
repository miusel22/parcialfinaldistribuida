import 'package:final_distribuida/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(parcialf());
}

class parcialf extends StatefulWidget {
  parcialf({Key? key}) : super(key: key);

  @override
  _parcialfState createState() => _parcialfState();
}

class _parcialfState extends State<parcialf> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vehicles App',
        home: LoginScreen());
  }
}
