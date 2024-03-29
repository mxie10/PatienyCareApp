import 'package:flutter/material.dart';
import 'package:patient_care_app/historyReview.dart';
import 'dart:convert';
import './patient_model.dart';
import 'package:http/http.dart' as http;

enum PatientStatus { stable, critical }

class PatientClinicalDetailsScreen extends StatefulWidget {
  final String? patienID;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? symptom;
  final String? sex;
  final String? emailAddress;
  PatientClinicalDetailsScreen(
      {required this.patienID,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.symptom,
      required this.sex,
      required this.emailAddress});

  @override
  _PatientClinicalDetailsState createState() => _PatientClinicalDetailsState();
}

class _PatientClinicalDetailsState extends State<PatientClinicalDetailsScreen> {
  late String? _patientID; // Declare _patientModel variable
  late String? _firstName;
  late String? _lastName;
  late String? _dateOfBirth;
  late String? _symptom;
  late String? _sex;
  late String? _emailAddress;
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController repositoryRateController = TextEditingController();
  TextEditingController bloodOxygenLevelController = TextEditingController();
  TextEditingController heartBeatRateController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String? bloodPressure = "";
  String? repositoryRate = "";
  String? bloodOxygenLevel = "";
  String? heartBeatRate = "";
  String? note = "";
  String _selectedValue = "";
  String? criticalCondition = "";
  List<PatientClinicalModel> clinicalRecord = [];
  List<String> _dropdownItems = [
    '',
    'Good',
    'Critical',
  ];

  PatientStatus _patientStatus = PatientStatus.stable;

  Future fetchClinicalDetail() async {
    clinicalRecord.clear();
    var response = await http
        .get(Uri.parse('http://localhost:5000/clinicalInfo?id=${_patientID}'));
    var jsonData = jsonDecode(response.body);

    for (var r in jsonData) {
      PatientClinicalModel record = PatientClinicalModel(
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
      clinicalRecord.add(record);
    }
    if (clinicalRecord.length != 0) {
      criticalCondition =
          clinicalRecord[clinicalRecord.length - 1].isInCriticalCondition;
    }
    return clinicalRecord;
  }

  void initState() {
    super.initState();
    _patientID = widget.patienID;
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    _dateOfBirth = widget.dateOfBirth;
    _symptom = widget.symptom;
    _sex = widget.sex;
    _emailAddress = widget.emailAddress;
  }

  submit() async {
    bloodPressure = bloodPressureController.text;
    repositoryRate = repositoryRateController.text;
    bloodOxygenLevel = bloodOxygenLevelController.text;
    heartBeatRate = heartBeatRateController.text;
    if (noteController.text == '') {
      note = "No clinical update for this patient";
    } else {
      note = noteController.text;
    }
    if ((bloodPressure != '' && double.tryParse(bloodPressure!) == null) ||
        repositoryRate != '' && double.tryParse(repositoryRate!) == null ||
        bloodOxygenLevel != '' && double.tryParse(bloodOxygenLevel!) == null ||
        heartBeatRate != '' && double.tryParse(heartBeatRate!) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please input a number."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    int intBloodPressure = int.parse(bloodPressure!);
    int intrepositoryRate = int.parse(repositoryRate!);
    int intbloodOxygenLevel = int.parse(bloodOxygenLevel!);
    int intheartBeatRate = int.parse(heartBeatRate!);

    var criticalStatus = "Good";

    if (intBloodPressure > 120 ||
        intrepositoryRate < 12 ||
        intheartBeatRate > 200 ||
        intbloodOxygenLevel <= 88) {
      criticalStatus = "Critical";
    }

    final url = Uri.parse('http://localhost:5000/clinicalInfo');
    final response = await http.post(url, body: {
      "patientId": _patientID.toString(),
      "firstName": _firstName,
      "lastName": _lastName,
      "dateOfBirth": _dateOfBirth,
      "sex": _sex,
      "emailAddress": _emailAddress,
      "symptom": _symptom,
      'bloodPressure': bloodPressure,
      'repositoryRate': repositoryRate,
      'bloodOxygenLevel': bloodOxygenLevel,
      'heartBeatRate': heartBeatRate,
      'isInCriticalCondition': criticalStatus,
      "date": DateTime.now().month.toString() +
          '/' +
          DateTime.now().day.toString() +
          "/" +
          DateTime.now().year.toString(),
      'comment': note,
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Your data has been submitted."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {});
    } else {
      // Failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Patient Clinical Info"),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 25),
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/avatars/clinical.jpg')
                              as ImageProvider),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                FutureBuilder(
                    future: fetchClinicalDetail(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (data.length != 0) {
                          bloodPressureController.text =
                              data[data.length - 1].bloodPressure;
                          repositoryRateController.text =
                              data[data.length - 1].repositoryRate;
                          bloodOxygenLevelController.text =
                              data[data.length - 1].bloodOxygenLevel;
                          heartBeatRateController.text =
                              data[data.length - 1].heartBeatRate;
                          noteController.text =
                              data[data.length - 1].description;
                        }
                      }
                      return Column(children: [
                        TextFormField(
                            controller: bloodPressureController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: '120/80 mm Hg',
                              labelText: 'BloodPressure(mm Hg):',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        TextFormField(
                            // initialValue: patientClinicalModel.respiratoryRate!,
                            controller: repositoryRateController,
                            enabled: true,
                            decoration: const InputDecoration(
                              hintText: '18/mins',
                              border: UnderlineInputBorder(),
                              labelText: 'RespiratoryRate(/mins):',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        TextFormField(
                            // initialValue: patientClinicalModel.bloodOxygenLevel,
                            controller: bloodOxygenLevelController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'BloodOxygenLevel(millimeters/mm Hg):',
                              hintText: '80 millimeters/mm Hg',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: heartBeatRateController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'HeartbeatRate(/mins):',
                              hintText: '80/mins',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale:
                                  1.0, // Increase the scale factor to make the text bigger
                              child: Text(
                                'Critical condition:',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: criticalCondition == ''
                                      ? Colors.blue
                                      : (criticalCondition == 'Good'
                                          ? Colors.green
                                          : (criticalCondition == 'Critical'
                                              ? Colors.red
                                              : Colors.red))),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale:
                                    1.0, // Increase the scale factor to make the text bigger
                                child: Text(
                                  'Status: ${criticalCondition}',
                                  style: TextStyle(
                                    color: criticalCondition == "Critical"
                                        ? Colors.red
                                        : Colors
                                            .green, // Change color based on status value
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                        TextField(
                          controller: noteController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Please add comment at here',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(160, 160, 160, 1)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              submit();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(left: 75, right: 75))),
                            child: Text('Update Clinical Information')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryReviewScreen(clinicalRecord)),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.brown),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(left: 90, right: 90))),
                            child: Text('Review Clinical History')),
                      ]);
                    })
              ],
            ))));
  }
}
