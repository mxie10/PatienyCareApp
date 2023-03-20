import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patient_care_app/patientDetails.dart';
import './patient_model.dart';
import './addPatientScreen.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super();

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen>
    with WidgetsBindingObserver {
  bool _refreshData = false;
  String _searchContent = '';
  Future getPatientData() async {
    var response = null;
    if(_searchContent == '')
      response = await http.get(Uri.parse('http://localhost:5000'));
    else
      response = await http.get(Uri.parse('http://localhost:5000/getPatientByName?firstName=${_searchContent}'));

    var jsonData = jsonDecode(response.body);
    List<PatientModel> patients = [];

    for (var p in jsonData) {
      PatientModel patient = PatientModel(
          p["_id"],
          p["patientUserName"],
          p["firstName"],
          p["lastName"],
          p["sex"],
          p["address"],
          p["dateOfBirth"],
          p["phoneNumber"],
          p["emailAddress"],
          p["symptom"]);
      // print(patient.patientId);
      patients.add(patient);
    }
    return patients;
  }

  getPatientByFirstName() {
      getPatientData();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  void updateList(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(241, 240, 240, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Jim Ryan",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      getPatientByFirstName();
                    },
                  ),
                ),
                onChanged: (value) {
                setState(() {
                  _searchContent = value;
                });
      },
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Card(
                    child: FutureBuilder(
                  future: getPatientData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                          child: Center(child: Text("Loading....")));
                    } else
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title: Text(
                            snapshot.data[index].firstName! +
                                ' ' +
                                snapshot.data[index].lastName!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data[index].dateOfBirth!,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: Text(
                            snapshot.data[index].symptom!,
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
                                  image: AssetImage('assets/avatars/user3.png')
                                      as ImageProvider),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                              color: Colors.redAccent,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientDetailsScreen(
                                        snapshot.data[index])));
                          },
                        ),
                      );
                  },
                )),
              ),
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPatient(),
                    ),
                  );
                  if (result == true) {
                    setState(() {
                      _refreshData = true;
                    });
                  }
                },
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
