import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/provider/provider.dart';
import 'package:online_quiz/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_screen.dart';
import 'firebase_options.dart';


var key ='';
var Url='';
var name='';
var email='';
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
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: "Online Quiz",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          // colorScheme: ColorScheme.dark(),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // Set your global border color here
            ),
            hintStyle: TextStyle(
              color: Colors.black
            )
          ),

        ),
        home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.active){

              if(snapshot.hasData){

                if(key=='Student'){
                  return AuthScreen(name: 'student', isst: true,);
                }
                else if(key=='Faculty'){
                  return AuthScreen(name: 'faculty');
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
            return Homesplesh();
      },
        ),
      ),
    );
  }


}



Future<void> getphotourl(String collname,BuildContext context) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(collname)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Provider.of<AppState>(context, listen: false).firstSnapshot = snapshot;
    print('Second Snapshot: ${snapshot['username']}');
    print(snapshot['photoUrl']);
    name=snapshot['username'];
    Url=snapshot['photoUrl'];
    email=snapshot['email'];
  } catch (e) {
    // Fluttertoast.showToast(msg: 'Some error occured');

  }

}