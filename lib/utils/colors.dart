import 'package:flutter/material.dart';
const BACKGROUND_COLOR = Color.fromRGBO( 240, 240, 240, 1.0);
const BACKGROUND_COLOR_LOADING = Color.fromRGBO( 185, 186, 185, 1.0);
const HEADING_COLOR = Color.fromRGBO( 23, 23, 23,1);
const TEXT_COLOR = Color.fromRGBO(23, 23, 23,1);
const TEXT_COLOR_WHITE = Color.fromRGBO( 255, 255, 255, 1.0);
const ORANGE_COLOR = Color.fromRGBO( 244, 84, 70, 1.0);
const RED_COLOR = Color.fromRGBO( 225, 42, 90, 1.0);
//
// class Student{
//   late int id;
//   late String name;
//
//   Student({required this.id, required this.name});
//   factory Student.fromJson(Map<dynamic,dynamic> json){
//     return Student(id: json['id'], name: json['name']);
//   }
// }
//
//
//  class CS{
//   late String semester;
//   late String strength;
//   late List<Student> students;
//
//   CS({required this.semester, required this.strength, required this.students});
//
//   factory CS.fromJson(Map<dynamic,dynamic> json){
//     var students = json['students'].map((e)=>Student.fromJson(e)).toList();
//     return CS(semester: json['semester'], strength: json['strength'], students: students);
//   }
//
// }
//
// var map = {
//   'semester':"4th",
//   'strength':'50',
//   'students':[
//     {
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },{
//       'id':182,
//       'name':'ahmad'
//     },
//   ]
// };
//
// var cs = CS.fromJson(map);