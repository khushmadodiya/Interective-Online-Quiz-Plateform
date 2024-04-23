import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_platform/screens/HomeScreen.dart';
import 'package:quiz_platform/screens/faculty/facultyScreen.dart';
import 'package:quiz_platform/screens/student/studentscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
var key ='';
var url='';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var pref = await SharedPreferences.getInstance();
  key = pref.getString('key').toString();
  print(key);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Set your global border color here
          ),
          hintStyle: TextStyle(
            color: Colors.white
          )
        ),

      ),
      home:  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){

              if(key=='Student'){
                getphotourl('student');
                return StudentScreen();
              }
              else if(key=='Faculty'){
                getphotourl('faculty');
                return FacultyScreen();
              }
            }
            else if(snapshot.hasError){
              return Center(child: Text('some error occur'),);
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return HomeScreen();
    },
      ),
    );
  }


}



Future<String> getphotourl(String collname) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection(collname)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  String Url = await snapshot['photoUrl'];
  print('url$Url');
  return Url;
}