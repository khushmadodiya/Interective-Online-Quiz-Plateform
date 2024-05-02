import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewScore extends StatefulWidget {
  final marks;
  final max;
  const ViewScore({super.key, required this.marks,required this.max});

  @override
  State<ViewScore> createState() => _ViewScoreState();
}

class _ViewScoreState extends State<ViewScore> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'You have completed the quiz.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Your score: ${widget.marks.toString()} out of ${widget.max.toString()} ', // Replace this with the actual score percentage
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // child: Text('${widget.marks.toString()} out of ${widget.max.toString()} '),
      ),
    );
  }
}
