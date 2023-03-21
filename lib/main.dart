import 'package:flutter/material.dart';
import './homeScreen.dart';
import './patientScreen.dart';
import './accountScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              backgroundColor: Colors.lightBlue,
              bottom: const TabBar(
                labelColor: Colors.white,
                tabs: [
                  SizedBox(
                      child: Tab(icon: Icon(Icons.people), text: "Patients")),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // HomeScreen(),
              PatientScreen(),
              // AccountScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
