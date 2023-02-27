import 'package:flutter/material.dart';
import './patient_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
static List<PatientModel> patient_list = [
    PatientModel("Jim012", "Jim", "Ryan","Male","16514 blenham way","07-09-1972","6541625413","jim@gmail.com","Fever"),
    PatientModel("Jim012", "Jim", "Ryan","Male","16514 blenham way","07-09-1972","6541625413","jim@gmail.com","Fever"),
    PatientModel("Jim012", "Jim", "Ryan","Male","16514 blenham way","07-09-1972","6541625413","jim@gmail.com","Fever"),
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
                        display_list[index].firstName! + display_list[index].lastName!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "DoB:" + display_list[index].dateOfBirth!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: Text(
                        display_list[index].symptom!,
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
