
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/input_text_field.dart';
import '../auth_screen.dart';
import '../provider/provider.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import 'faculty/facultyScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  String selectedValue = value1;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
   final Width=MediaQuery.of(context).size.width;
   final Height=MediaQuery.of(context).size.height;
   login()async{
     setState(() {
       flag = true;
     });

     String res = await AuthMethod().loginUser(email: emailcontroller.text.trim(), password: passcontroller.text.trim(),type: selectedValue);
     setState(() {
       flag = false;
     });
     if(res=='success'){
       try{
         String doc=FirebaseAuth.instance.currentUser!.uid.toString();
         print(doc);
         var snap= await FirebaseFirestore.instance.collection(selectedValue.toLowerCase()).doc(doc).get();
         Provider.of<AppState>(context, listen: false).firstSnapshot = snap;
         print(snap['email']);
         var pref = await SharedPreferences.getInstance();
         pref.setString('key', selectedValue);
       }
       catch(e){
         res='user not found';
         AuthMethod().signOut();
       }


     }

     if(selectedValue == value1 && res =='success'){
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AuthScreen(name: 'student',isst:true)), (route) => false);
     }
     else if(selectedValue == value2 && res =='success'){
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AuthScreen(name: 'faculty')), (route) => false);
     }
     shosnacbar(context, res);
   }

    return GestureDetector(
      onTap: (){ FocusScope.of(context).unfocus();},
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: Width > 600
                ? EdgeInsets.symmetric(
                horizontal: Width / 2.9)
                : const EdgeInsets.symmetric(horizontal: 32),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  autofocus:true,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: <String>[value1, value2,]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(fontSize: 25))
                    );
                  }).toList(),
                ),
                SizedBox(height: 25,),
                InputText(controller: emailcontroller, hint: "Enter your Email"),
                SizedBox(height: 20,),
                InputText(controller: passcontroller, hint:'Enter password',ispass: true,isform: true,),
                SizedBox(height: 25,),
                FilledButton(onPressed:login, child: flag?CircularProgressIndicator(color: Colors.white,): Text('  Log in  ')),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have accunt '),
                      InkWell(
                          child: Text('Regiter',style: TextStyle(color: Colors.deepPurple),),
                        onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
