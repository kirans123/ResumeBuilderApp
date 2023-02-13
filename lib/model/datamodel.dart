import 'dbhelper.dart';

class Car {
  int? id;
  final String name;
  final int miles;

  Car({this.id, required this.name, required this.miles});

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(id: map['id'], name: map['name'], miles: map['miles']);
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles,
    };
  }
}

class ResumeModel {
  int? id;
  final String fname;
  final String lname;
  final int age;
  final String totalYearsOfExperience;
  final String? pasportNo;
  final String maritalStatus;

  final List<String> expertise;
  final List<PastExperinceList> passExperinceList;
  final List<String> projectsExecuted;

  ResumeModel(
      {required this.fname,
      required this.lname,
      required this.age,
      required this.totalYearsOfExperience,
      required this.pasportNo,
      required this.maritalStatus,
      required this.expertise,
      required this.passExperinceList,
      required this.projectsExecuted});
}

class PastExperinceList {
  final String companyName;
  final String fromDate;
  final String toDate;

  PastExperinceList(
      {required this.companyName,
      required this.fromDate,
      required this.toDate});

  factory PastExperinceList.fromMap(Map<String, dynamic> map) {
    return PastExperinceList(
        companyName: map['companyName'],
        fromDate: map['fromDate'],
        toDate: map['toDate']);
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.companyName: companyName,
      DatabaseHelper.fromDate: fromDate,
      DatabaseHelper.toDate: toDate,
    };
  }
}
