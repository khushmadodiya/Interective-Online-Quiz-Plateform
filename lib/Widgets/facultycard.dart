import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/firestore_methso.dart';
import '../screens/faculty/marks_screen.dart';
import '../screens/faculty/question_screen.dart';
import '../utils/utils.dart';

class FacultyCard extends StatefulWidget {
  final snap;
  const FacultyCard({
    super.key,
    required this.snap,
  });

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {


  void _copyToClipboard() {
    Clipboard.setData(
        ClipboardData(text:widget.snap['quizuid'].toString()));
    Navigator.pop(context);
    shosnacbar(context, 'Text copied to clipboard');
  }



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
          image: DecorationImage(
            image: AssetImage("assets/quizCard.jpg"),
            fit: BoxFit.cover,
          ),
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              subtitle: Text(
                widget.snap['subname'].toString(),
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: () async {
                  showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: [
                            SimpleDialogOption(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text('Share Quiz',style: TextStyle(fontSize: 15,color: Colors.white),),),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.deepPurple)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: SelectableText(
                                              widget.snap['quizuid'].toString(),
                                              style: TextStyle(fontSize: 15,color: Colors.white),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _copyToClipboard,
                                        icon: Icon(Icons.copy,color: Colors.white,),
                                      ),
                                      IconButton(onPressed: (){
                                        // Share.share('Click here https://online-quiz-8566e.web.app/ and join throught this code ${ widget.snap['quizuid'].toString()}');
                                        Navigator.pop(context);
                                      }, icon: Icon(Icons.share,color: Colors.white,))
                                    ],
                                  ),
                                ),
                                onPressed: () {}),
                            SizedBox(
                              height: 10,
                            ),
                            SimpleDialogOption(
                                child: Container(
                                 padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
                                  child: Center(child: Text('Delete Quiz', style: TextStyle(fontSize: 20,color: Colors.white),)),
                                ),
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
                                                          await FireStoreMethos()
                                                              .deleteequiz(
                                                                  quizuid: widget
                                                                          .snap[
                                                                      'quizuid']);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      shosnacbar(context, res);
                                                    },
                                                    child: Text('Yes'))
                                              ]));
                                }),
                            SimpleDialogOption(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black
                                ),
                                  child: Center(child: Text('Student Marks List',style: TextStyle(fontSize: 20,color: Colors.white),))),
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudnetsMarksScreen(snap: widget.snap,)));
                              },

                            )
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.more_vert,color: Colors.white,),
              ),
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
