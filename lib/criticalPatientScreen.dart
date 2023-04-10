import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patient_care_app/patientDetails.dart';
import './patient_model.dart';
import './addPatientScreen.dart';

class CriticalPatientScreen extends StatefulWidget {
  const CriticalPatientScreen({Key? key}) : super();

  @override
  _CriticalPatientScreenState createState() => _CriticalPatientScreenState();
}

class _CriticalPatientScreenState extends State<CriticalPatientScreen>
    with WidgetsBindingObserver {
  bool _refreshData = false;
  String _searchContent = '';

  Future getPatientData() async {
    var response = null;
    var critical = "Critical";
    response = await http.get(Uri.parse(
        'http://localhost:5000/getCriticalPatient?condition=$critical'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<PatientClinicalModel> patients = [];
      List<String> list = [];
      for (var r in jsonData) {
        PatientClinicalModel patient = PatientClinicalModel(
            r["patientId"],
            r["firstName"],
            r["lastName"],
            r["dateOfBirth"],
            r["sex"],
            r["emailAddress"],
            r["symptom"],
            r["bloodPressure"],
            r["repositoryRate"],
            r["bloodOxygenLevel"],
            r["heartBeatRate"],
            r["isInCriticalCondition"],
            r["comment"],
            r["date"]);
        // print(patient.patientId);
        if (!list.contains(r["patientId"])) {
          patients.add(patient);
          list.add(r["patientId"]);
        }
      }
      return patients;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
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
      backgroundColor: Color.fromRGBO(247, 246, 242, 1),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Card(
                    child: FutureBuilder(
                  future: getPatientData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                          child: Center(child: Text("Loading....")));
                    } else {
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
                            snapshot.data[index].emailAddress!,
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
                                  image: snapshot.data[index].sex! == 'Male'
                                      ? AssetImage('assets/avatars/male.jpg')
                                      : AssetImage('assets/avatars/female.jpg')
                                  // image: AssetImage('assets/avatars/user3.png')
                                  //     as ImageProvider
                                  ),
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
                                        snapshot.data[index].patientId))).then(
                                (value) => setState(() {}));
                          },
                        ),
                      );
                    }
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
