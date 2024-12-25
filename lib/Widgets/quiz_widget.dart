import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/firestore_methso.dart';
import '../utils/utils.dart';

class QuizWidget extends StatefulWidget {
  final snap;
  final quizuid;

  final index;
  const QuizWidget(
      {super.key, required this.snap, this.index, required this.quizuid,});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedValue = 0;
  Future<void> check() async {
    print(widget.snap!['ans']);
    print('option$selectedValue');
    if (widget.snap!['ans'] == 'option$selectedValue') {
      print('yes');
      String res = await FireStoreMethos().updateans(
          quid: widget.quizuid, index: widget.index);
      // print(res);
    }
    else {
      String res = await FireStoreMethos().updatetozero(
          quid: widget.quizuid, index: widget.index);
      print('no');
      // print (res);
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: Text(
              '${widget.index.toString()})',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            title: Text(
              '${widget.snap['question'].toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          RadioListTile(
            value: 1,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                print(selectedValue);
                check();
              });
            },
            title: Text(
              widget.snap['option1'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option2'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 3,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option3'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 4,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option4'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
        ]));
  }

}