import 'package:flutter/material.dart';
import './patient_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super();

  @override
  State<AccountScreen> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  static List<PatientModel> patient_list = [
    PatientModel("Jim Ryan", 55, "Fever"),
    PatientModel("Tom Holland", 26, "Cough"),
    PatientModel("YiQing", 22, "Covid"),
    PatientModel("Jim Ryan", 55, "Fever"),
    PatientModel("Tom Holland", 26, "Cough"),
  ];

  List<PatientModel> display_list = List.from(patient_list);

  void updateList(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              // const Text("Account",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 22.0,
              //         fontWeight: FontWeight.bold)),
              // const SizedBox(
              //   height: 20.0,
              // ),
              const Image(
                image: AssetImage('assets/avatars/user2.jpg'),
                height: 200,
                width: 200,
              ),
              TextFormField(
                  initialValue: 'doctorStrange123',
                  enabled: false,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username:',
                  )),
              TextFormField(
                  initialValue: 'Stephen',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'First Name',
                  )),
              TextFormField(
                  initialValue: 'Strange',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Last Name',
                  )),
              TextFormField(
                  initialValue: 'drststrange@gmail.com',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  )),
              TextFormField(
                  initialValue: '+1 123 1234 1111',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Contact',
                  )),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 120, right: 120))),
                  child: Text('Update')),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 1,
                endIndent: 0,
                color: Colors.black,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 86, right: 86))),
                  child: Text('Change Password')),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 121, right: 121))),
                  child: Text('Logout')),
            ],
          )),
    );
  }
}
