import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/Widgets/custom_floatingbutton.dart';
import '../../Widgets/question_card.dart';
import '../../utils/utils.dart';
import 'add_questions.dart';

class QuestionScreen extends StatefulWidget {
  final snap;
  const QuestionScreen({super.key, required this.snap});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.snap['quiztitle'].toString()),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
            child: Divider(
              thickness: 1,
              color: Colors.black54,
            ),
          )),
      floatingActionButton: CustomFloatingbutton(ontap: (){ Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddQuestion(
                snap: widget.snap,
              )));}),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('quiz')
              .doc(widget.snap['quizuid'].toString())
              .collection('questions')
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
                return QuestionCard(
                  snap: snapshot.data!.docs[index].data(),
                  index: index+1,
                  quizuid:widget.snap['quizuid'].toString()
                );
              },
            );
          }),
    );
  }
}
