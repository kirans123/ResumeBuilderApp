import '../resumedbhelper.dart';
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
  final String mobile;
  final int age;
  final String totalYearsOfExperience;
  final String? pasportNo;
  final String maritalStatus;

  /*final List<String> expertise;
  final List<PastExperinceList> passExperinceList;
  final List<Projects> projectsExecuted;*/

  ResumeModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.age,
    required this.totalYearsOfExperience,
    required this.pasportNo,
    required this.maritalStatus,
    //required this.expertise,
    // required this.passExperinceList,
    // required this.projectsExecuted,
  });

  factory ResumeModel.fromMap(Map<String, dynamic> map) {
    return ResumeModel(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      mobile: map['mobile'],
      age: map['age'],
      totalYearsOfExperience: map['totalYearsOfExperience'],
      pasportNo: map['pasportNo'],
      maritalStatus: map['maritalStatus'],
      /* expertise: map['expertise'].map<String>((value) {
        return value.toString();
      }).toList(),
      passExperinceList:
          map['passExperinceList'].map<PastExperinceList>((value) {
        return PastExperinceList.fromMap(value);
      }).toList(),
      projectsExecuted: map['projectsExecuted'].map<Projects>((value) {
        return Projects.fromMap(value);
      }).toList(),*/
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ResumeDatabaseHelper.columnId: id,
      ResumeDatabaseHelper.fname: fname,
      ResumeDatabaseHelper.lname: lname,
      ResumeDatabaseHelper.age: age,
      ResumeDatabaseHelper.totalYearsOfExperience: totalYearsOfExperience,
      ResumeDatabaseHelper.pasportNo: pasportNo,
      ResumeDatabaseHelper.maritalStatus: maritalStatus,
      //DatabaseHelper.expertise: expertise,
      //DatabaseHelper.maritalStatus: maritalStatus,
    };
  }
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
      ResumeDatabaseHelper.companyName: companyName,
      ResumeDatabaseHelper.fromDate: fromDate,
      ResumeDatabaseHelper.toDate: toDate,
    };
  }
}

class Projects {
  final String projectName;
  final String projectDetails;

  Projects({
    required this.projectName,
    required this.projectDetails,
  });

  factory Projects.fromMap(Map<String, dynamic> map) {
    return Projects(
      projectName: map['projectName'],
      projectDetails: map['projectDetails'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ResumeDatabaseHelper.projectName: projectName,
      ResumeDatabaseHelper.projectDetails: projectDetails,
    };
  }
}
