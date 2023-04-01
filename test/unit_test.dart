import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patient_care_app/patientClinicalDetails.dart';

void main() {
  group("Unit Test", () {
    test(
        '1 - when all the clinical Tests are in normal range / within good value',
        () {
      final bloodPressureController = TextEditingController(text: '100');
      final repositoryRateController = TextEditingController(text: '100');
      final bloodOxygenLevelController = TextEditingController(text: '100');
      final heartBeatRateController = TextEditingController(text: '100');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

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
    });

    test(
        '2 - when all the clinical Tests are in normal range EXCEPT blood Pressue (> 120)',
        () {
      // Arrange
      final bloodPressureController = TextEditingController(text: '150');
      final repositoryRateController = TextEditingController(text: '100');
      final bloodOxygenLevelController = TextEditingController(text: '100');
      final heartBeatRateController = TextEditingController(text: '100');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });

    test(
        '3 - when all the clinical Tests are in normal range EXCEPT Repository Rate  (< 12)',
        () {
      final bloodPressureController = TextEditingController(text: '100');
      final repositoryRateController = TextEditingController(text: '10');
      final bloodOxygenLevelController = TextEditingController(text: '100');
      final heartBeatRateController = TextEditingController(text: '100');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });

    test(
        '4 - when all the clinical Tests are in normal range EXCEPT Blood Oxygen  ( =  88)',
        () {
      // Arrange
      final bloodPressureController = TextEditingController(text: '100');
      final repositoryRateController = TextEditingController(text: '10');
      final bloodOxygenLevelController = TextEditingController(text: '88');
      final heartBeatRateController = TextEditingController(text: '100');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });

    test(
        '4 - when all the clinical Tests are in normal range EXCEPT Blood Oxygen  ( <  88)',
        () {
      // Arrange
      final bloodPressureController = TextEditingController(text: '100');
      final repositoryRateController = TextEditingController(text: '100');
      final bloodOxygenLevelController = TextEditingController(text: '86');
      final heartBeatRateController = TextEditingController(text: '100');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });

    test(
        '5 - when all the clinical Tests are in normal range EXCEPT Heart Beat  ( >  200)',
        () {
      // Arrange
      final bloodPressureController = TextEditingController(text: '100');
      final repositoryRateController = TextEditingController(text: '100');
      final bloodOxygenLevelController = TextEditingController(text: '100');
      final heartBeatRateController = TextEditingController(text: '210');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });

    test('6 - when all the clinical Tests are in not within normal range', () {
      // Arrange
      final bloodPressureController = TextEditingController(text: '121');
      final repositoryRateController = TextEditingController(text: '11');
      final bloodOxygenLevelController = TextEditingController(text: '210');
      final heartBeatRateController = TextEditingController(text: '80');
      final noteController =
          TextEditingController(text: 'this is a sample test note');

      // Act
      final result = calculateCriticalStatus(
        bloodPressureController,
        repositoryRateController,
        bloodOxygenLevelController,
        heartBeatRateController,
        noteController,
      );

      // Assert
      expect(result, 'Critical');
    });
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
