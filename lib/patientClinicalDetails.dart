import 'package:flutter/material.dart';
import './patient_model.dart';

class PatientClinicalDetailsScreen extends StatelessWidget {
  
  final PatientModel patientModel;
  PatientClinicalDetailsScreen(this.patientModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Patient Clinical Info"),
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
                      // initialValue: patientClinicalModel.bloodPressure,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: '120/80 mm Hg',
                        labelText: 'BloodPressure:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      // initialValue: patientClinicalModel.respiratoryRate!,
                      enabled: true,
                      decoration: const InputDecoration(
                        hintText: '18/mins',
                        border: UnderlineInputBorder(),
                        labelText: 'RespiratoryRate:',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      // initialValue: patientClinicalModel.bloodOxygenLevel,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'BloodOxygenLevel:',
                        hintText: '80 millimeters/mm Hg',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                  TextFormField(
                      // initialValue: patientClinicalModel.heartbeatRate,
                      enabled: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'HeartbeatRate:',
                        hintText: '80/mins',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(232, 228, 228, 1)),
                        ),
                    )),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orange),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 90, right: 90))),
                      child: Text('Update Clinical Info')),
                    // Text(
                    //   'Update History',
                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: 20),
                    TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Please add comment at here',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(160, 160, 160, 1)),
                          ),
                        ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 90, right: 90))),
                      child: Text('Update Clnical History')),
                ]
              )
            ),
          
        )
      );
  }
}
