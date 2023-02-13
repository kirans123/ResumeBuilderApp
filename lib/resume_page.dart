import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:resume_builder_app/model/datamodel.dart';
import 'package:resume_builder_app/model/view_resume.dart';
import 'package:resume_builder_app/resumedbhelper.dart';
import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final dbHelper = ResumeDatabaseHelper.instance;

  List<ResumeModel> resumeModelList = [];
  List<ResumeModel> resumeModelByMobile = [];

  //controllers used in insert operation UI
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController totalYearsController = TextEditingController();
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();

  TextEditingController profileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  //controllers used in update operation UI
  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController milesUpdateController = TextEditingController();

  //controllers used in delete operation UI
  TextEditingController idDeleteController = TextEditingController();

  //controllers used in query operation UI
  TextEditingController queryController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _showMessageInScaffold(String message) {
    /*  _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));*/
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
    print("RECEIVED MESSAGE --> $message");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Insert",
              ),
              Tab(
                text: "View",
              ),
              Tab(
                text: "Query",
              ),
              Tab(
                text: "Update",
              ),
              Tab(
                text: "Delete",
              ),
            ],
          ),
          title: Text('Resume Builder'),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      setTextField("First name", fnameController),
                      setTextField("Last name", lnameController),
                      setTextField("Mobile Number", mobileController),
                      setTextField("Profile", profileController),
                      setTextField("Address", addressController),
                      setTextField("Email", emailController),
                      setTextField("About Me", aboutMeController),
                      setTextField("Age", ageController),
                      setTextField(
                          "Total No. of Experience", totalYearsController),
                      setTextField("Passport No.", passportNumberController),
                      setTextField("Marital Status", maritalStatusController),
                      ElevatedButton(
                        child: Text('Insert Details'),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState!.save();
                            _insert();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ViewProfile(
              resumeModelList: resumeModelList,
            ),
            /*Container(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: resumeModelList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == resumeModelList.length) {
                    return ElevatedButton(
                      child: Text('Refresh'),
                      onPressed: () {
                        setState(() {
                          _queryAll();
                        });
                      },
                    );
                  }
                  return ViewProfile(
                    resumeModelList: resumeModelList,
                  );
                  /*Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        '[${resumeModelList[index].id}] ${resumeModelList[index].fname} - ${resumeModelList[index].lname}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );*/
                },
              ),
            ),*/
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                      ),
                      onChanged: (text) {
                        if (text.length >= 2) {
                          setState(() {
                            _query(text);
                          });
                        } else {
                          setState(() {
                            resumeModelByMobile.clear();
                          });
                        }
                      },
                    ),
                    height: 100,
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: resumeModelByMobile.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              '[${resumeModelByMobile[index].id}] ${resumeModelByMobile[index].fname} - ${resumeModelByMobile[index].lname}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car id',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: milesUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car Miles',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Update Car Details'),
                    onPressed: () {
                      int id = int.parse(idUpdateController.text);
                      String name = nameUpdateController.text;
                      int miles = int.parse(milesUpdateController.text);
                      _update(id, name, miles);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idDeleteController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Car id',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      int id = int.parse(idDeleteController.text);
                      _delete(id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      ResumeDatabaseHelper.fname: fnameController.text,
      ResumeDatabaseHelper.lname: lnameController.text,
      ResumeDatabaseHelper.mobile: mobileController.text,
      ResumeDatabaseHelper.age: int.parse(ageController.text),
      ResumeDatabaseHelper.totalYearsOfExperience: totalYearsController.text,
      ResumeDatabaseHelper.pasportNo: passportNumberController.text,
      ResumeDatabaseHelper.maritalStatus: maritalStatusController.text,
      ResumeDatabaseHelper.profile: profileController.text,
      ResumeDatabaseHelper.address: addressController.text,
      ResumeDatabaseHelper.email: emailController.text,
      ResumeDatabaseHelper.aboutMe: aboutMeController.text,
    };
    ResumeModel resumeModel = ResumeModel.fromMap(row);
    // print(car);
    final id = await dbHelper.insert(resumeModel);
    _showMessageInScaffold('inserted row id: $id');
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    resumeModelList.clear();
    allRows.forEach((row) => resumeModelList.add(ResumeModel.fromMap(row)));
    _showMessageInScaffold('Query done.');
    setState(() {});
  }

  void _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    resumeModelByMobile.clear();
    allRows.forEach((row) => resumeModelByMobile.add(ResumeModel.fromMap(row)));
  }

  void _update(id, fname, lname) async {
    // row to update
    /*  ResumeModel car = ResumeModel(id: id, fname: fname, lname: lname);
    final rowsAffected = await dbHelper.update(car);
    _showMessageInScaffold('updated $rowsAffected row(s)');*/
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    _showMessageInScaffold('deleted $rowsDeleted row(s): row $id');
  }

  Widget setTextField(String caption, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: caption,
        ),
        validator: (value) {
          if (value == "") {
            return "$caption should not be empty";
          }
        },
      ),
    );
  }

  Widget getView() {
    _queryAll();
    return ViewProfile(
      resumeModelList: resumeModelList,
    );
  }
}
