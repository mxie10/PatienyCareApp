import 'package:flutter/material.dart';
import './patientClinicalDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './patient_model.dart';

class PatientDetailsScreen extends StatefulWidget {
  final String patientID;
  PatientDetailsScreen(this.patientID);

  @override
  _PatientDetailsScreen createState() => _PatientDetailsScreen();
}

class _PatientDetailsScreen extends State<PatientDetailsScreen> {
  late String? _patientID;
  String? firstName = "";
  String? lastName = "";
  String? dob = "";
  String? sex = "";
  String? address = "";
  String? phoneNumber = "";
  String? email = "";
  String? symotom = "";
  PatientModel patientModel =
      PatientModel("", "", "", "", "", "", "", "", "", "");
  List<String> _dropdownSexItems = ['', 'Male', 'Female'];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController symptomController = TextEditingController();

  void initState() {
    super.initState();
    _patientID = widget.patientID; // Initialize _patientModel variable
  }

  Future fetchPatientDetail() async {
    var response = await http.get(
        Uri.parse('http://localhost:5000/getPatientByID?id=${_patientID}'));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    // for (var r in jsonData) {
    //   PatientModel record = PatientModel(
    //     r["_id"],
    //     r["patientUserName"],
    //     r["firstName"],
    //     r["lastName"],
    //     r["sex"],
    //     r["address"],
    //     r["dateOfBirth"],
    //     r["phoneNumber"],
    //     r["emailAddress"],
    //     r["symptom"],
    //   );
    //   patientModel = record;
    // }

    PatientModel record = PatientModel(
      jsonData[0]["_id"],
      jsonData[0]["patientUserName"],
      jsonData[0]["firstName"],
      jsonData[0]["lastName"],
      jsonData[0]["sex"],
      jsonData[0]["address"],
      jsonData[0]["dateOfBirth"],
      jsonData[0]["phoneNumber"],
      jsonData[0]["emailAddress"],
      jsonData[0]["symptom"],
    );
    patientModel = record;
    return patientModel;
  }

  updatePatientInfo() async {
    print('iin????');
    final url = Uri.parse(
        'http://localhost:5000/updatePatientInfo?id=${patientModel.patientId}');

    var response = await http.patch(url, body: {
      // 'firstName': firstName == '' ? patientModel.firstName : firstName,
      // 'lastName': lastName == '' ? patientModel.lastName : lastName,
      // 'sex': sex == '' ? patientModel.sex : sex,
      // 'address': address == '' ? patientModel.address : address,
      // 'dateOfBirth': dob == '' ? patientModel.dateOfBirth : dob,
      // 'phoneNumber': phoneNumber == '' ? patientModel.phoneNumber : phoneNumber,
      // 'emailAddress': email == '' ? patientModel.emailAddress : email,
      // 'symptom': symotom == '' ? patientModel.symptom : symotom

      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'sex': patientModel.sex,
      'address': addressController.text,
      'dateOfBirth': dateOfBirthController.text,
      'phoneNumber': phoneNumberController.text,
      'emailAddress': emailAddressController.text,
      'symptom': symptomController.text
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
                FutureBuilder(
                    future: fetchPatientDetail(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // if (data) {
                        firstNameController.text = data.firstName;
                        lastNameController.text = data.lastName;
                        sexController.text = data.sex;
                        addressController.text = data.address;
                        dateOfBirthController.text = data.dateOfBirth;
                        phoneNumberController.text = data.phoneNumber;
                        emailAddressController.text = data.emailAddress;
                        symptomController.text = data.symptom;
                        // }
                      }
                      return Column(children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: patientModel.sex == 'Male'
                                      ? AssetImage('assets/avatars/male.jpg')
                                      : AssetImage(
                                          'assets/avatars/female.jpg')),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        TextFormField(
                            controller: firstNameController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'First Name:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        TextFormField(
                            // initialValue: patientClinicalModel.respiratoryRate!,
                            controller: lastNameController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Last Name:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: addressController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Address:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: dateOfBirthController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Date of Birth:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: phoneNumberController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Phone Number:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: emailAddressController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email Address:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            // initialValue: patientClinicalModel.heartbeatRate,
                            controller: symptomController,
                            enabled: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Symptom:',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(232, 228, 228, 1)),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              updatePatientInfo();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 137)),
                            ),
                            child: Text('Update')),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PatientClinicalDetailsScreen(
                                          patienID: data.patientId,
                                          firstName: data.firstName!,
                                          lastName: data.lastName,
                                          dateOfBirth: data.dateOfBirth,
                                          symptom: data.symptom,
                                          sex: data.sex,
                                          emailAddress: data.emailAddress)),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 123)),
                          ),
                          child: Text('Clinical Info'),
                        ),
                      ]);
                    })

                // TextFormField(
                //   initialValue: patientModel.firstName!,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'First Name:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       firstName = value;
                //     });
                //   },
                // ),
                // TextFormField(
                //   initialValue: patientModel.lastName!,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'Last Name:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       lastName = value;
                //     });
                //   },
                // ),
                // TextFormField(
                //   initialValue: patientModel.dateOfBirth!,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'DoB:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       dob = value;
                //     });
                //   },
                // ),
                // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                //   Transform.scale(
                //     scale:
                //         1.0, // Increase the scale factor to make the text bigger
                //     child: Text(
                //       'Sex:',
                //       style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1)),
                //     ),
                //   ),
                //   DropdownButton(
                //     value: sex,
                //     items: _dropdownSexItems.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         sex = newValue!;
                //       });
                //     },
                //   ),
                // ]),
                // TextFormField(
                //   initialValue: patientModel.address,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'Address:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       address = value;
                //     });
                //   },
                // ),
                // TextFormField(
                //   initialValue: patientModel.phoneNumber,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'PhoneNumber:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       phoneNumber = value;
                //     });
                //   },
                // ),
                // TextFormField(
                //   initialValue: patientModel.emailAddress,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'EmailAddress:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       email = value;
                //     });
                //   },
                // ),
                // TextFormField(
                //   initialValue: patientModel.symptom,
                //   enabled: true,
                //   decoration: const InputDecoration(
                //     border: UnderlineInputBorder(),
                //     labelText: 'Syptom:',
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                //     ),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       symotom = value;
                //     });
                //   },
                // ),
              ])),
        ));
  }
}
