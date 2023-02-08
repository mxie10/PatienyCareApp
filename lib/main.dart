import 'package:flutter/material.dart';  
import './HomeScreen.dart';  
import './PatientScreen.dart';
  
void main() => runApp(MyApp());  
  
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      color: Colors.white,
      home: DefaultTabController(  
        length: 2,  
        child: Scaffold(  
          backgroundColor: Colors.black,
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child:AppBar(  
              backgroundColor: Colors.black,
              bottom: TabBar(  
                tabs: [  
                  SizedBox(
                    height:70,
                    child: Tab(icon: Icon(Icons.home), text: "Home")
                  ),
                    SizedBox(
                    height:70,
                    child: Tab(icon: Icon(Icons.people), text: "Patients") 
                  )
                ],  
              ),  
            ),  
          ),
          body: TabBarView(  
            children: [  
              HomeScreen(),  
              PatientScreen(),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}  


