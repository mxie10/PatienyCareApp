import 'package:flutter/material.dart';
import 'dart:convert';
import './patient_model.dart';
import 'package:http/http.dart' as http;

enum PatientStatus { stable, critical }

class PatientClinicalDetailsScreen extends StatefulWidget {
  final PatientModel patientModel;
  PatientClinicalDetailsScreen({required this.patientModel});

  @override
  _PatientClinicalDetailsState createState() => _PatientClinicalDetailsState();
}

class _PatientClinicalDetailsState extends State<PatientClinicalDetailsScreen> {
  late PatientModel _patientModel; // Declare _patientModel variable
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

  List<String> _dropdownItems = [
    '',
    'Good',
    'Serious',
    'Critical',
  ];

  PatientStatus _patientStatus = PatientStatus.stable;

  Future fetchClinicalDetail() async {
    var response = await http.get(Uri.parse(
        'http://localhost:5000/clinicalInfo?id=${_patientModel.patientId}'));
    var jsonData = jsonDecode(response.body);
    List<PatientClinicalModel> clinicalRecord = [];
    for (var r in jsonData) {
      PatientClinicalModel record = PatientClinicalModel(
          r["patientId"],
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
      criticalCondition = clinicalRecord[clinicalRecord.length-1].isInCriticalCondition;
      print("excute??????");
    }
    // print("The length is:" + clinicalRecord.length.toString());
    return clinicalRecord;
  }

  void initState() {
    super.initState();
    _patientModel = widget.patientModel; // Initialize _patientModel variable
  }

  submit() async {
    bloodPressure = bloodPressureController.text;
    repositoryRate = repositoryRateController.text;
    bloodOxygenLevel = bloodOxygenLevelController.text;
    heartBeatRate = heartBeatRateController.text;
    note = noteController.text;

    final url = Uri.parse('http://localhost:5000/clinicalInfo');
    final response = await http.post(url, body: {
      "patientId": _patientModel.patientId.toString(),
      'bloodPressure': bloodPressure,
      'repositoryRate': repositoryRate,
      'bloodOxygenLevel': bloodOxygenLevel,
      'heartBeatRate': heartBeatRate,
      'isInCriticalCondition': _selectedValue,
      "date": DateTime.now().month.toString() +
          '-' +
          DateTime.now().day.toString() +
          "-" +
          DateTime.now().year.toString(),
      'comment': note,
    });

    if (response.statusCode == 200) {
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
                          image: AssetImage('assets/avatars/user3.png')
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
                              labelText: 'BloodPressure:',
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
                              labelText: 'RespiratoryRate:',
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
                              labelText: 'BloodOxygenLevel:',
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
                              labelText: 'HeartbeatRate:',
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
                                color: criticalCondition == '' ? Colors.blue : (criticalCondition == 'Good' ? Colors.green : (criticalCondition == 'Serious' ? Colors.orange : Colors.red))
                              ),
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
                                'Change critical condition:',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DropdownButton(
                              value: _selectedValue,
                              items: _dropdownItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedValue = newValue!;
                                });
                              },
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
                                    EdgeInsets.only(left: 90, right: 90))),
                            child: Text('Update Clinical History')),
                      ]);
                    })
              ],
            ))));
  }
}
