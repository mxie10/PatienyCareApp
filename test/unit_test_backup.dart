import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patient_care_app/patientClinicalDetails.dart';

void main() {
  test('criticalStatus is calculated correctly', () {
    // Arrange
    final bloodPressureController = TextEditingController(text: '121');
    final repositoryRateController = TextEditingController(text: '12');
    final bloodOxygenLevelController = TextEditingController(text: '88');
    final heartBeatRateController = TextEditingController(text: '200');
    final noteController = TextEditingController(text: 'Some note');

    // Act
    final result = calculateCriticalStatus(
      bloodPressureController,
      repositoryRateController,
      bloodOxygenLevelController,
      heartBeatRateController,
      noteController,
    );

    // Assert
    expect(result, 'Good');

    // Arrange
    bloodPressureController.text = '122';

    // Act
    final result2 = calculateCriticalStatus(
      bloodPressureController,
      repositoryRateController,
      bloodOxygenLevelController,
      heartBeatRateController,
      noteController,
    );

    // Assert
    expect(result2, 'Critical');
  });
}

String calculateCriticalStatus(
  TextEditingController bloodPressureController,
  TextEditingController repositoryRateController,
  TextEditingController bloodOxygenLevelController,
  TextEditingController heartBeatRateController,
  TextEditingController noteController,
) {
  final bloodPressure = bloodPressureController.text;
  final repositoryRate = repositoryRateController.text;
  final bloodOxygenLevel = bloodOxygenLevelController.text;
  final heartBeatRate = heartBeatRateController.text;
  final note = noteController.text;

  final intBloodPressure = int.parse(bloodPressure!);
  final intrepositoryRate = int.parse(repositoryRate!);
  final intbloodOxygenLevel = int.parse(bloodOxygenLevel!);
  final intheartBeatRate = int.parse(heartBeatRate!);

  var criticalStatus = "Good";

  if (intBloodPressure > 120 ||
      intrepositoryRate < 12 ||
      intheartBeatRate > 200 ||
      intbloodOxygenLevel <= 88) {
    criticalStatus = "Critical";
  }

  return criticalStatus;
}
