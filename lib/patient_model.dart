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
      this.symptom
    );
}

class PatientClinicalModel {
    String? patientId;
    String? bloodPressure;
    String? respiratoryRate;
    String? bloodOxygenLevel;
    String? heartbeatRate;
    String? description;
    String? date;

    PatientClinicalModel(
      this.patientId,
      this.bloodPressure,
      this.respiratoryRate,
      this.bloodOxygenLevel,
      this.heartbeatRate,
      this.description,
      this.date
    );
}