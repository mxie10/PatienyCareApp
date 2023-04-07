import 'package:flutter/material.dart';
import './patientScreen.dart';
import './criticalPatientScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: DefaultTabController(
        length: 2,
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
                          fontSize: 19, // Change the font size to 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Tab(
                      icon: Icon(Icons.warning),
                      child: Text(
                        "Critical Patients",
                        style: TextStyle(
                          fontSize: 19, // Change the font size to 20
                        ),
                      ),
                    ),
                  ), // A
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              PatientScreen(),
              CriticalPatientScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
