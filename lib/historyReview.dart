// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:patient_care_app/patient_model.dart';

class CustomListTile extends ListTile {
  List<PatientClinicalModel> clinicalRecord;
  int index;

  CustomListTile(this.clinicalRecord, this.index)
      : super(
          title: Text(clinicalRecord[index].date.toString(),
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.0),
              Text( "BP:" + clinicalRecord[index].bloodPressure.toString() 
                + " | " + "RR:"+clinicalRecord[index].repositoryRate.toString()),
              SizedBox(height: 2.0),
              Text( "BOL:" + clinicalRecord[index].bloodOxygenLevel.toString()
                + " | " + "HBR:"+clinicalRecord[index].heartBeatRate.toString()),
              SizedBox(height: 2.0),
              Text(
                "Note:" + clinicalRecord[index].description.toString(),
                style: TextStyle(
                    color: Colors.pink,
                  )
                ),
            ],
          ),
          leading: Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: clinicalRecord[index].isInCriticalCondition == ''
                    ? Colors.blue
                    : (clinicalRecord[index].isInCriticalCondition == 'Good'
                        ? Colors.green
                        : (clinicalRecord[index].isInCriticalCondition ==
                                'Serious'
                            ? Colors.orange
                            : Colors.red))),
          ),
          onTap: () {},
        );
}

class HistoryReviewScreen extends StatelessWidget {
  List<PatientClinicalModel> clinicalRecord;
  HistoryReviewScreen(this.clinicalRecord);

  List<String> textLines = ["bloodPressure:","test","test","test"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Clinical History')),
        body: ListView.builder(
            itemCount: clinicalRecord.length,
            itemBuilder: (context, index) {
              final clinical = clinicalRecord[index];
              return Card(
                child: CustomListTile(
                  clinicalRecord,index
                ),
              );
            }));
    throw UnimplementedError();
  }
}
