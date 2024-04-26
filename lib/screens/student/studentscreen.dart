import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_platform/screens/HomeScreen.dart';
import 'package:quiz_platform/screens/offline%20quizes/guess_name.dart';
import 'package:quiz_platform/screens/offline%20quizes/spot_the_diffrence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/student_card.dart';
import '../../main.dart';
import '../../resources/auth_methods.dart';
import '../login_screen.dart';
import '../sign_up_screen.dart';
import 'joinquiz.dart';

class StudentScreen extends StatefulWidget {
  final quizuid;
  const StudentScreen({super.key, this.quizuid});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String quizid='';
  String url ='https://www.google.com/imgres?q=person%20image&imgurl=https%3A%2F%2Ft3.ftcdn.net%2Fjpg%2F01%2F65%2F63%2F94%2F360_F_165639425_kRh61s497pV7IOPAjwjme1btB8ICkV0L.jpg&imgrefurl=https%3A%2F%2Fstock.adobe.com%2Fsearch%3Fk%3Dperson&docid=u8MkgSDI8RpPkM&tbnid=mor2oqglmbZcuM&vet=12ahUKEwjSvd3C0NiFAxUGlK8BHQqwDoQQM3oECH4QAA..i&w=360&h=360&hcb=2&ved=2ahUKEwjSvd3C0NiFAxUGlK8BHQqwDoQQM3oECH4QAA';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 1),
        ()async{
          url = await getphotourl('student');
          setState(() {

          });
        }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
      showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                  child: Center(
                    child: Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple[100],
                      ),
                      height: 40,
                      child: Center(
                        child: Text(
                          'Spot the difference',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Spot()));
                  }),
              SimpleDialogOption(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple[100],
                    ),
                    child: Center(
                      child: Text(
                        'Guess the name',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    height: 40,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Guess()));
                  }),
            ],
          );
        }
        );
          },
          icon: FaIcon(FontAwesomeIcons.bars),
        ),
        title: Text('Online Quiz'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
          child: Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                  ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(url)),
            ),
            
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                            child: Center(
                                child: Text(
                                  'Log out',
                                  style: TextStyle(fontSize: 20),
                                )),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: Text('Are you sure'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('No')),
                                        TextButton(
                                            onPressed: () async {
                                              String res =
                                              await AuthMethod()
                                                  .signOut();
                                              if (res == 'success') {
                                                var pref =
                                                await SharedPreferences
                                                    .getInstance();
                                                pref.setString('key', '');
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            HomeScreen()),(route) => false
                                                );
                                              }
                                            },
                                            child: Text('Yes')),
                                      ]));
                            }),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => JoinQuiz()));
        },
        child: Center(child: Text('Join')),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('student').doc(FirebaseAuth.instance.currentUser!.uid).collection('quizes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return snapshot.data!.docs.length<=0?Container(
                child: Text('hello'),
              ):StudentCard(
                snap: snapshot.data!.docs[index].data(),
              );
            },
          );
        },
      ),
    );
  }
}