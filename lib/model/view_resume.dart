import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_builder_app/model/datamodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resumedbhelper.dart';

class ViewProfile extends StatefulWidget {
  final List<ResumeModel> resumeModelList;
  static final String path = "lib/src/pages/profile/profile4.dart";

  const ViewProfile({super.key, required this.resumeModelList});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  final dbHelper = ResumeDatabaseHelper.instance;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),

      //LISTVIEW WAS NOT SCROLLING SO ADDED THIS
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.resumeModelList.length,
              itemBuilder: (BuildContext context, index) {
                return setRow(widget.resumeModelList[index]);
              })
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _queryAll();
    });
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    widget.resumeModelList.clear();
    allRows
        .forEach((row) => widget.resumeModelList.add(ResumeModel.fromMap(row)));
    print('Query done.');
    setState(() {});
  }

  Widget setRow(ResumeModel model) {
    print('${widget.resumeModelList.length}');
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(model),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Text("${model.aboutMe}"),
          ),
          _buildTitle("Skills"),
          SizedBox(height: 10.0),
          _buildSkillRow("Wordpress", 0.75),
          SizedBox(height: 5.0),
          _buildSkillRow("Laravel", 0.6),
          SizedBox(height: 5.0),
          _buildSkillRow("React JS", 0.65),
          SizedBox(height: 5.0),
          _buildSkillRow("Flutter", 0.5),
          SizedBox(height: 30.0),
          _buildTitle("Experience"),
          _buildExperienceRow(
              company: "GID India",
              position: "Wordpress Developer",
              duration: "2010 - 2012"),
          _buildExperienceRow(
              company: "LTI Tech",
              position: "Laravel Developer",
              duration: "2012 - 2015"),
          SizedBox(height: 20.0),
          _buildTitle("Education"),
          SizedBox(height: 5.0),
          _buildExperienceRow(
              company: "Tribhuvan University, India",
              position: "B.Sc. Computer Science and Information Technology",
              duration: "2011 - 2015"),
          _buildExperienceRow(
              company: "Cambridge University, UK",
              position: "A Level",
              duration: "2008 - 2010"),
          _buildExperienceRow(
              company: "Pune Board", position: "SLC", duration: "2008"),
          SizedBox(height: 20.0),
          _buildTitle("Contact"),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              SizedBox(width: 30.0),
              Icon(
                Icons.mail,
                color: Colors.black54,
              ),
              SizedBox(width: 10.0),
              Text(
                "${model.email}",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 30.0),
              Icon(
                Icons.phone,
                color: Colors.black54,
              ),
              SizedBox(width: 10.0),
              Text(
                "${model.mobile}",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          _buildSocialsRow(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: () {
            _launchURL("https://facebook.com/kirankulkarni");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.github),
          onPressed: () {
            _launchURL("https://github.com/kirankulkarni");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: Icon(FontAwesomeIcons.youtube),
          onPressed: () {
            _launchURL("https://youtube.com/c/kirankulkarni");
          },
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _buildExperienceRow(
      {required String company, String? position, String? duration}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader(ResumeModel model) {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
          width: 80.0,
          height: 80.0,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 35.0,
              //backgroundImage: NetworkImage(avatars[4]),
              // backgroundImage: Icon(Icons.person_off_outlined),
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${model.fname} ${model.lname}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text("${model.profile}"),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "${model.address}",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
