import 'package:flutter/material.dart';
import './patientClinicalDetails.dart';
import './patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  final PatientModel patientModel;
  PatientClinicalModel data = PatientClinicalModel("userName","110","172","10","100","none","2-9-2023");

  PatientDetailsScreen(this.patientModel);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Patient Details"),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child:SingleChildScrollView(
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
                      width: 120.0,
                      height: 120.0,
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
                  TextFormField(
                      initialValue: patientModel.firstName! + ' ' +  patientModel.lastName!,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'PatientName:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientModel.dateOfBirth!,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'DoB:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientModel.sex,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Sex:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientModel.address,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Address:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    TextFormField(
                      initialValue: patientModel.phoneNumber,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'PhoneNumber:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    TextFormField(
                      initialValue: patientModel.emailAddress,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'EmailAddress:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    TextFormField(
                      initialValue: patientModel.symptom,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Syptom:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PatientClinicalDetailsScreen(data)),
                        );
                      },
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 100)),
                        ),
                        child: Text('ClinicalInfo'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 112)),
                          ),
                      child: Text('Update')),
                ]
              )
            ),
          
        )
      );
  }
}
