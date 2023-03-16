import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();

  String _patientUserName = '';
  String _firstName = '';
  String _lastName = '';
  String _dob = '';
  String _sex = '';
  String _address = '';
  String _phoneNumber = '';
  String _email = '';
  String _symptom = '';
  submit() async {
    await http.post(
        Uri.parse('http://localhost:5000'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'patientUserName': _patientUserName,
          'firstName': _firstName,
          'lastName': _lastName,
          'sex': _sex,
          'address': _address,
          'dateOfBirth': _dob,
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Patient User Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient user name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _patientUserName = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date of birth';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _dob = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sex',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter sex';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your cellphonen number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Symptom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter symptom';
                    }
                    return null;
                  },
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
                  )
                )
              ]
            )
          )
        )
      ));
  }
}