import 'package:flutter/material.dart';
import './patient_model.dart';

class PatientClinicalDetailsScreen extends StatelessWidget {
  final PatientClinicalModel patientClinicalModel;
  PatientClinicalDetailsScreen(this.patientClinicalModel);

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
                      initialValue: patientClinicalModel.bloodPressure,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'BloodPressure:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientClinicalModel.respiratoryRate!,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'RespiratoryRate:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientClinicalModel.bloodOxygenLevel,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'BloodOxygenLevel:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      initialValue: patientClinicalModel.heartbeatRate,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'HeartbeatRate:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    TextFormField(
                      initialValue: patientClinicalModel.description,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 120, right: 120))),
                      child: Text('Update')),
                ]
              )
            ),
          
        )
      );
  }
}
