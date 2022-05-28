
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
showSnackBar(context,text,color,textColor){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text,style: TextStyle(color: textColor),),
    backgroundColor: color,
    duration: const Duration(milliseconds: 3000),
  ));
}