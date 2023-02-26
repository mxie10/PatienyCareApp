import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patient_care_app/patientDetails.dart';
import './patient_model.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super();

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {

  static List<PatientModel> patient_list = [
    PatientModel("Jim Ryan", 55, "Fever","120","12","95","110"),
    PatientModel("Tom Holland", 26, "Cough","120","12","95","110"),
    PatientModel("YiQing", 22, "Covid","120","12","95","110"),
    PatientModel("Jim Ryan", 55, "Fever","120","12","95","110"),
    PatientModel("Tom Holland", 26, "Cough","120","12","95","110"),
  ];

  List<PatientModel> display_list = List.from(patient_list);

  void updateList(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text("Patient List",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20.0),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: Color(0xff302360),
                  fillColor: Color.fromRGBO(241, 240, 240, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Jim Ryan",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                      display_list[index].patient_name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Age:" + display_list[index].patient_age!.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Text(
                      display_list[index].patient_syptom!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/avatars/user3.png') as ImageProvider
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientDetailsScreen(display_list[index])));
                    },
                  ),
                ),
              )
            ],
          )
        ),
    );
  }
}
