import 'package:flutter/material.dart';
import './patientClinicalDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './patient_model.dart';

class PatientDetailsScreen extends StatefulWidget {
  final PatientModel patientModel;
  PatientDetailsScreen(this.patientModel);

  @override
  _PatientDetailsScreen createState() => _PatientDetailsScreen();
}

class _PatientDetailsScreen extends State<PatientDetailsScreen> {
  late PatientModel _patientModel;
  String? firstName = "";
  String? lastName = "";
  String? dob = "";
  String? sex = "";
  String? address = "";
  String? phoneNumber = "";
  String? email = "";
  String? symotom = "";
  List<String> _dropdownSexItems = ['', 'Male', 'Female'];

  void initState() {
    super.initState();
    _patientModel = widget.patientModel; // Initialize _patientModel variable
  }

  updatePatientInfo() async {
    print('iin????');
    final url = Uri.parse(
        'http://localhost:5000/updatePatientInfo?id=${_patientModel.patientId}');

    var response = await http.patch(url, body: {
      'firstName': firstName == '' ? _patientModel.firstName : firstName,
      'lastName': lastName == '' ? _patientModel.lastName : lastName,
      'sex': sex == '' ? _patientModel.sex : sex,
      'address': address == '' ? _patientModel.address : address,
      'dateOfBirth': dob == '' ? _patientModel.dateOfBirth : dob,
      'phoneNumber':
          phoneNumber == '' ? _patientModel.phoneNumber : phoneNumber,
      'emailAddress': email == '' ? _patientModel.emailAddress : email,
      'symptom': symotom == '' ? _patientModel.symptom : symotom
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("The info has been successfully updated!"),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(patientModel.patientId);
    return Scaffold(
        appBar: AppBar(
          title: Text("Patient Details"),
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
                  margin: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _patientModel.sex == 'Male'
                              ? AssetImage('assets/avatars/male.jpg')
                              : AssetImage('assets/avatars/female.jpg')),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: _patientModel.firstName!,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'First Name:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _patientModel.lastName!,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Last Name:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _patientModel.dateOfBirth!,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'DoB:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      dob = value;
                    });
                  },
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Transform.scale(
                    scale:
                        1.0, // Increase the scale factor to make the text bigger
                    child: Text(
                      'Sex:',
                      style: TextStyle(
                          color: Color.fromRGBO(96, 96, 96, 1)),
                    ),
                  ),
                  DropdownButton(
                    value: sex,
                    items: _dropdownSexItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        sex = newValue!;
                      });
                    },
                  ),
                ]),
                TextFormField(
                  initialValue: _patientModel.address,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Address:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _patientModel.phoneNumber,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'PhoneNumber:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _patientModel.emailAddress,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'EmailAddress:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _patientModel.symptom,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Syptom:',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      symotom = value;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      updatePatientInfo();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 137)),
                    ),
                    child: Text('Update')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientClinicalDetailsScreen(
                              patientModel: _patientModel)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 123)),
                  ),
                  child: Text('Clinical Info'),
                ),
              ])),
        ));
  }
}
