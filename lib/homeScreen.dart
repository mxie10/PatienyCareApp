import 'package:flutter/material.dart';
import './patient_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text("Welcome back doctor!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
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
                          color: Colors.black,
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
                      // leading: Image.asset('assets/avatar/patient_example.jpg'),
                      leading: SizedBox(
                          height: 100,
                          width: 60,
                          child: Icon(
                            Icons.portrait_outlined,
                            color: Colors.blue.shade400,
                            size: 55,
                          ))),
                ),
              )
            ],
          )),
    );
  }
}
