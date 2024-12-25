import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/quiz_widget.dart';
import '../../resources/fetchquestions.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';

int marks = 0;



class Circulerendicator extends StatefulWidget {

  final snap;

  const Circulerendicator({super.key, required this.snap,});

  @override
  State<Circulerendicator> createState() => _CirculerendicatorState();
}

class _CirculerendicatorState extends State<Circulerendicator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 2),
        ()async{
          var list = await FetchQuestions().fetch(widget.snap['quizuid']);
          Random random = Random();
          for (var i = list.length - 1; i > 0; i--) {
            var j = random.nextInt(i + 1);
            var temp = list[i];
            list[i] = list[j];
            list[j] = temp;
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz(snap: widget.snap,list: list,)));
        }
    );

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class Quiz extends StatefulWidget {
  final snap;

  final List<Map<String,String>>list;
  const Quiz({super.key, required this.snap, required this.list});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Future<void> getmarks() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .doc(widget.snap['quizuid'])
        .collection('students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    marks = snapshot['marks'];
  }

  @override
  void initState() {
    super.initState();
    getmarks();
  }

  @override
  void dispose() {
    super.dispose();
    marks = 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body:   ListView.builder(
          itemCount: widget.list.length + 1,
          itemBuilder: (context, index) {
            return index == widget.list.length
                ? Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width > webScreenSize ? width * 0.3 : 30,
                  vertical: width > webScreenSize ? 15 : 10,
                ),
                width: double.infinity,
                child: FilledButton(onPressed:()=>_submit(widget.list.length.toString()), child: Text('Submit'))
            )
                : QuizWidget(
              snap: widget.list[index],
              index: index + 1,
              quizuid: widget.snap['quizuid'],
            );
          })
    );
  }



  void _submit(length) async{
    int a = int.parse(length);
    print(a);
    String res = await FireStoreMethos().submitQuiz(quid: widget.snap['quizuid'], lenght: a);
    print(res);
    if(res=='success'){
      Navigator.pop(context);
    }
  }
}
// SizedBox(height: 10,),
// FilledButton(onPressed: (){}, child: Text('Submit'))
