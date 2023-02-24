import 'package:flutter/material.dart';
import './patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  final PatientModel patientModel;
  PatientDetailsScreen(this.patientModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Patient Details"),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
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
                  width: 140.0,
                  height: 140.0,
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
                  initialValue: patientModel.patient_name,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'PatientName:',
                )),
               TextFormField(
                  initialValue: patientModel.patient_age.toString(),
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'PatientAge:',
                )),
               TextFormField(
                  initialValue: patientModel.bloodOxygenLevel,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'bloodOxygenLevel:',
                )),
               TextFormField(
                  initialValue: patientModel.bloodPressure,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'bloodPressure:',
                )),
                TextFormField(
                  initialValue: patientModel.respiratoryRate,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'respiratoryRate:',
                )),
                TextFormField(
                  initialValue: patientModel.heartbeatRate,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'heartbeatRate:',
                )),
                TextFormField(
                  initialValue: patientModel.patient_syptom,
                  enabled: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Syptom:',
                )),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 120, right: 120))),
                  child: Text('Update')),
            ]))
        );
  }
}
