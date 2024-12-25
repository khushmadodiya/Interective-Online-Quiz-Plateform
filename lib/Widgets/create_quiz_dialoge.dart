import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/input_text_field.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';

class CreateQuizDialog extends StatefulWidget {
  const CreateQuizDialog({super.key});

  @override
  State<CreateQuizDialog> createState() => _CreateQuizDialogState();
}

class _CreateQuizDialogState extends State<CreateQuizDialog> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();

  _submit() async {
    String res = await FireStoreMethos().createquiz(
      quiztitle: titlecontroller.text.trim(),
      name: namecontroller.text.trim(),
      subname: subjectcontroller.text.trim(),
    );
    if (res == 'success') {
      shosnacbar(context, res);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width/1.6,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Quiz",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                InputText(controller: titlecontroller, hint: "Enter Quiz Title"),
                const SizedBox(height: 20),
                InputText(controller: namecontroller, hint: "Enter Your Name"),
                const SizedBox(height: 20),
                InputText(
                  controller: subjectcontroller,
                  hint: "Enter Subject Name (optional)",
                ),
                const SizedBox(height: 30),
                FilledButton(onPressed: _submit, child: const Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog
void showCreateQuizDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const CreateQuizDialog();
    },
  );
}
