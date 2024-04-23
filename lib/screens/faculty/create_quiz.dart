import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/input_text_field.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';
import 'facultyScreen.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();
  _submit()async{
    String res = await FireStoreMethos().createquiz(quiztitle: titlecontroller.text.trim(), name: namecontroller.text.trim(), subname: subjectcontroller.text.trim());
    if(res=='success'){
      shosnacbar(context, res);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FacultyScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Quiz"),
        ),

      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              InputText(controller: titlecontroller, hint: "Enter QuizTitle"),
              SizedBox(
                height: 20,
              ),
              InputText(controller:namecontroller, hint: "Enter your Name"),
              SizedBox(
                height: 20,
              ),
              InputText(controller:subjectcontroller, hint: "Enter subject name (optional)"),
              SizedBox(
                height: 20,
              ),
              FilledButton(onPressed: _submit, child: Text('  Submit  ')),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
