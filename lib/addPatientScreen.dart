import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'components/customizedTextInput.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();

  String _patientUserName = '';
  String _firstName = '';
  String _lastName = '';
  String _sex = '';
  String _address = '';
  String _phoneNumber = '';
  String _email = '';
  String _symptom = '';

  DateTime _selectedDate = DateTime.now();
  String _selectedSex = '';
  List<String> _dropdownSexItems = ['', 'Male', 'Female'];

  submit() async {
    if (_patientUserName == '' ||
        _firstName == '' ||
        _lastName == '' ||
        _phoneNumber == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill out all of the fields"),
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
    await http.post(
      Uri.parse('http://localhost:5000'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'patientUserName': _patientUserName,
        'firstName': _firstName,
        'lastName': _lastName,
        'sex': _selectedSex,
        'address': _address,
        'dateOfBirth': _selectedDate.toString().substring(0, 10),
        'phoneNumber': _phoneNumber,
        'emailAddress': _email,
        'symptom': _symptom
      }),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Patient'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      CustomTextField(
                        labelText: 'UserName',
                        onChanged: (value) {
                          setState(() {
                            _patientUserName = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'First Name',
                        onChanged: (value) {
                          setState(() {
                            _firstName = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'last Name',
                        onChanged: (value) {
                          setState(() {
                            _lastName = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null && picked != _selectedDate) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                        child: Text('Date of Birth'),
                      ),
                      Text(
                          'Selected date: ${_selectedDate.toString().substring(0, 10)}'),
                      SizedBox(height: 16.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale:
                                  1.0, // Increase the scale factor to make the text bigger
                              child: Text(
                                'Sex:',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DropdownButton(
                              value: _selectedSex,
                              items: _dropdownSexItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedSex = newValue!;
                                });
                              },
                            ),
                          ]),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'Address',
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'Cellphone Number:',
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'Email',
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: 'Symptom',
                        onChanged: (value) {
                          setState(() {
                            _symptom = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                submit();
                              },
                              child: Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 20,
                                ),
                              ),
                            ),
                          ))
                    ])))));
  }
}
