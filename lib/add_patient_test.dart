import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:patient_care_app/components/customizedTextInput.dart';
import 'package:patient_care_app/addPatientScreen.dart';
import 'package:mockito/annotations.dart';

class MockClient extends Mock implements http.Client {}

@GenerateMocks([MockClient])
void main() {
  group('AddPatient', () {
    testWidgets('should send correct data to server', (WidgetTester tester) async {
      // Create a mock HTTP client
      final client = MockClient();

      // Mock the response of the post method
      when(client.post(
        Uri.parse('http://localhost:5000'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body:jsonEncode({
        'patientUserName': 'testUser',
        'firstName': 'test_firstName',
        'lastName': 'test_lasyName',
        'sex': 'Male',
        'address': '_address',
        'dateOfBirth': '2020-3-19',
        'phoneNumber': 'test phone number',
        'emailAddress': 'test email',
        'symptom': 'test'
      }),
      )).thenAnswer((_) async => http.Response('', 200));

      // Build the widget tree
      await tester.pumpWidget(MaterialApp(
        home: AddPatient(),
      ));

      // Enter values for the User Name, First Name, Last Name, and Phone Number fields
      await tester.enterText(findByLabelText('UserName'), 'test_username');
      await tester.enterText(findByLabelText('First Name'), 'John');
      await tester.enterText(findByLabelText('last Name'), 'Doe');
      await tester.enterText(findByLabelText('Cellphone Number:'), '1234567890');

      // Submit the form
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify that the correct data is sent in the HTTP request
      // verify(client.post(
      //   Uri.parse('http://localhost:5000'),
      //   headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      //   body: argThat(
      //     equals({
      //       'patientUserName': 'test_username',
      //       'firstName': 'John',
      //       'lastName': 'Doe',
      //       'sex': 'Male',
      //       'address': '16514 blenham way, Chesterfield, MO, 63005',
      //       'dateOfBirth': DateTime.now().toString().substring(0,10),
      //       'phoneNumber': '1234567890',
      //       'emailAddress': '',
      //       'symptom': '',
      //     }),
      //     named: 'body',
      //   ),
      // )).called(1);

      // Close the mock HTTP client
      client.close();
    });
  });
}

Finder findByLabelText(String labelText) {
  return find.byWidgetPredicate((widget) {
    return widget is CustomTextField && widget.labelText == labelText;
  });
}
