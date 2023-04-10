class PatientModel {
  String? patientId;
  String? userName;
  String? firstName;
  String? lastName;
  String? sex;
  String? address;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? symptom;

  PatientModel(
      this.patientId,
      this.userName,
      this.firstName,
      this.lastName,
      this.sex,
      this.address,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.symptom);
}

class PatientClinicalModel {
  String? patientId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? sex;
  String? emailAddress;
  String? symptom;
  String? bloodPressure;
  String? repositoryRate;
  String? bloodOxygenLevel;
  String? heartBeatRate;
  String? isInCriticalCondition;
  String? description;
  String? date;

  PatientClinicalModel(
      this.patientId,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.sex,
      this.emailAddress,
      this.symptom,
      this.bloodPressure,
      this.repositoryRate,
      this.bloodOxygenLevel,
      this.heartBeatRate,
      this.isInCriticalCondition,
      this.description,
      this.date);
}
