import 'package:flutter/material.dart';
class WidgetsDesign{
  Widget otpWidget (){
  return BottomSheet(onClosing: (){}, builder: (context) {
    return Column(children: [
        const SizedBox(height: 200,),
        Container(child: const Text("Anjad"),),
        const SizedBox(height: 200,),
    ],);
},);}
}
