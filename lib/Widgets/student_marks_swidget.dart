import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class StudentMarksWidget extends StatefulWidget {
  final snap;
  final index;
  const StudentMarksWidget({super.key, required this.snap, this.index});

  @override
  State<StudentMarksWidget> createState() => _StudentMarksWidgetState();
}

class _StudentMarksWidgetState extends State<StudentMarksWidget> {
  String name ='';
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return name==''?Center(child: CircularProgressIndicator(),) :Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        // height: MediaQuery.of(context).size.height / 8,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 174, 242, 100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
           leading: Text(
             '${widget.index}',
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

           ),
            title: Text(
             name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              widget.snap['marks'].toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
        ));
  }

  void getname() async{
   String uid = widget.snap['studentuid'].toString();
   try{
     DocumentSnapshot snapshot =await FirebaseFirestore.instance.collection('student').doc(uid).get();
     setState(() {
       name = snapshot['username'];
     });

     print(name);
   }
   catch(e){
     print('error occured');
   }
  }
}
