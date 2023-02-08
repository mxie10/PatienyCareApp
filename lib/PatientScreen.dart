import 'package:flutter/material.dart';  
  
class PatientScreen extends StatefulWidget {  
  const PatientScreen({Key?key}):super();

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}  

class _PatientScreenState extends State<PatientScreen> {

  void updateList(String value){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search for a patient",
              style:TextStyle(
                color:Colors.white,
                fontSize: 22.0,fontWeight: 
                FontWeight.bold
              )
            ),
            SizedBox(
              height:20.0
            ),
            TextField(
              style:TextStyle(color:Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xff302360),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Jim Ryan",
                prefixIcon:Icon(Icons.search),
                prefixIconColor: Colors.purple.shade900,
              ),
            ),
            SizedBox(
              height:20.0,
            ),
            Expanded(
              child:ListView()
            )
          ],
        )
      ),
    );
  }
}