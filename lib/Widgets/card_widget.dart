import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../globle.dart';
import '../resources/firestore_methso.dart';
import '../screens/offline quizes/msg_screen.dart';
import 'input_text_field.dart';

class CardWid extends StatefulWidget {
  final index;
  final isspot;
  const CardWid({super.key, required this.index, this.isspot=false});

  @override
  State<CardWid> createState() => _CardWidState();
}

class _CardWidState extends State<CardWid> {
  bool flag =false;
  TextEditingController anscontroller = TextEditingController();
  void sendans(ans,int index)async{

    hideTextInput();
    var res =await FireStoreMethos().setAns(ans,index.toString(),widget.isspot ? 'spot': 'Gess');
    print(res);
    if(res=='s'){
      Fluttertoast.showToast(msg: 'succses');
    }


  }
  @override
  Widget build(BuildContext context) {
   var Width = MediaQuery.of(context).size.width;
    return Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 0),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          child: Container(
            height: MediaQuery.of(context).size.height/2.87,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black
            ),
            child:
            Column(
                children: [
                  widget.isspot ?Container(height:MediaQuery.of(context).size.height/3.67,child: Image.asset('assets/spot/${spot[widget.index]}')):Container(height:MediaQuery.of(context).size.height/3.67,child: Image.asset('assets/animals/${animals[widget.index]}')),
                  Container(
                      height: MediaQuery.of(context).size.height/14,
                      decoration: BoxDecoration(
                          color: Colors.black,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            if(flag){
                              setState(() {
                                flag=false;
                              });
                            }
                            else{
                              setState(() {
                                flag=true;
                              });
                            }
                          }, icon: flag ?  Icon(Icons.favorite,color: Colors.deepPurple,):Icon( Icons.favorite_outline)),
                          Expanded(
                            child: InputText(controller: anscontroller, hint: '   Enter answer ..')
                          ),
                          IconButton(onPressed: (){
                            sendans(anscontroller.text.trim(),widget.index);
                            anscontroller.clear();
                          }, icon: Icon(Icons.send_outlined,color: Colors.deepPurple,)),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MsgScreen(name: widget.isspot ? 'spot':'Gess', index: widget.index)));
                          }, icon: Icon(Icons.message ,))
                        ],
                      )
                  ),
                ]
            ),
          )
      )
    );
  }
}
