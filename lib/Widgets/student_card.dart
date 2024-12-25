import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/faculty/question_screen.dart';
import '../screens/student/quiz_screen.dart';
import '../screens/student/view_score.dart';
import '../utils/utils.dart';

class StudentCard extends StatefulWidget {
  final snap;

  const StudentCard({
    super.key,
    required this.snap,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  int marks=0;
  int max=0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Future<void> getmarks() async {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('quiz')
          .doc(widget.snap['quizuid'])
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      marks= snapshot['marks'];
      max =snapshot['totalmarks'];
    }
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 174, 242, 100),
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("assets/quizCard.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: InkWell(
          onTap: () {
           if(widget.snap['status']){
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => QuestionScreen(snap: widget.snap)));
           }
          },
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              title: Text(
                widget.snap['quiztitle'].toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              subtitle: Text(
                widget.snap['subname'].toString(),
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
              trailing:!widget.snap['status']?ElevatedButton(
                onPressed: (){
                  print('/n');
                  print(widget.snap['quizuid']);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Circulerendicator(snap: widget.snap, )));},
                child: Text('Join Quiz'),
              ):ElevatedButton(
                onPressed: ()async{
                  print('/n');
                  print(widget.snap['quizuid']);
                  await getmarks();
                  print(marks);
                  showMarksDialog(context,marks.toString(),max.toString());},
                child: Text('View Score'),
              )

            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.snap['name'],
                    style: TextStyle(fontSize: 15,color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
