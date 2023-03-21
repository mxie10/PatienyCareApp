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
                    child: Tab(
                      icon: Icon(Icons.people),
                      child: Text(
                        "Patient List",
                        style: TextStyle(
                          fontSize: 18, // Change the font size to 20
                        ),
                      ),
                  ))
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
