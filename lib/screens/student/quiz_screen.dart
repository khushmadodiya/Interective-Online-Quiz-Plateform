import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/quiz_widget.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';

int marks = 0;

class Quiz extends StatefulWidget {
  final snap;
  const Quiz({super.key, required this.snap});

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quiz')
            .doc(widget.snap['quizuid'])
            .collection('questions')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length + 1,
              itemBuilder: (context, index) {
                return index == snapshot.data!.docs.length
                    ? Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width > webScreenSize ? width * 0.3 : 30,
                      vertical: width > webScreenSize ? 15 : 10,
                    ),
                    width: double.infinity,
                    child: FilledButton(onPressed:()=>_submit(snapshot.data!.docs.length.toString()), child: Text('Submit'))
                )
                    : QuizWidget(
                        snap: snapshot.data!.docs[index].data(),
                        index: index + 1,
                        quizuid: widget.snap['quizuid'],
                      );
              });
        },
      ),
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
