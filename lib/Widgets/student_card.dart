import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/faculty/question_screen.dart';
import '../screens/student/quiz_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionScreen(snap: widget.snap)));
          },
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              title: Text(
                widget.snap['quiztitle'].toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.snap['subname'].toString(),
                style: TextStyle(fontSize: 15),
              ),
              trailing:ElevatedButton(
                onPressed: (){
                  print('/n');
                  print(widget.snap['quizuid']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Quiz(snap: widget.snap,)));},
                child: Text('Join Quiz'),
              )
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.snap['name'],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
