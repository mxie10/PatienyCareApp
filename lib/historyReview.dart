// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:patient_care_app/patient_model.dart';

class CustomListTile extends ListTile {
  final List<String> textLines;
  
  CustomListTile(this.textLines) :
    super(
      title: Text(textLines[0]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textLines[1]),
          Text(textLines[2]),
          Text(textLines[3]),
          Text(textLines[4]),
          Text(textLines[5]),
        ],
      ),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {},
    );
}

class HistoryReviewScreen extends StatelessWidget {
  List<PatientClinicalModel> clinicalRecord;
  HistoryReviewScreen(this.clinicalRecord);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Clinical History')),
        body: ListView.builder(
            itemCount: clinicalRecord.length,
            itemBuilder: (context, index) {
              final clinical = clinicalRecord[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: clinicalRecord[index].isInCriticalCondition == ''
                            ? Colors.blue
                            : (clinicalRecord[index].isInCriticalCondition ==
                                    'Good'
                                ? Colors.green
                                : (clinicalRecord[index]
                                            .isInCriticalCondition ==
                                        'Serious'
                                    ? Colors.orange
                                    : Colors.red))),
                  ),
                  title: Text(
                    clinicalRecord[index].date.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    clinicalRecord[index].description.toString(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }));
    throw UnimplementedError();
  }
}
