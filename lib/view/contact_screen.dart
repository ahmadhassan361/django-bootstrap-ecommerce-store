import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quantum_genius/models/user_models.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/functions.dart';
import '../utils/fontsize.dart';
import 'package:quantum_genius/utils/shared_pref_funcs.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var fullNameController = TextEditingController();
  var subjectController = TextEditingController();
  var commentController = TextEditingController();
  var emailController = TextEditingController();

  AuthModel? authModel;
  bool isLoading=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> saveUserDetails(id,fullname,mobile,address,city,zipcode,province) async{
        var map = <dynamic,dynamic>{};

        map['fullname'] = fullname;
        map['mobile'] = mobile;
        map['address'] = address;
        map['city'] = city;
        map['zipcode'] = zipcode;
        map['province'] = province;

        final response = await http.post(
          Uri.parse('$BASE_URL$MY_DETAILS_END_POINT$id'),
          headers: {
            "Authorization": "Token ${authModel!.token}"
          },
          body: map,
        );
        if(response.statusCode==200){
          final res = jsonDecode(response.body);
          if(!res['error']){
            return true;
          }
          return false;
        }
        return false;

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: HEADING_COLOR
        ),
        title: const Text("My Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0,left: 10),
                      child: Text(
                        'FullName:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Full Name Required";
                          }
                          return null;
                        },
                        controller:fullNameController,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10),
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (val){
                          if(val!.isEmpty){
                            return "Invalid Email";
                          }
                          return null;
                        },
                        controller:emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10),
                      child: Text(
                        'Subject:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (val){
                          if(val!.isEmpty){
                            return "Subject Required";
                          }
                          return null;
                        },
                        controller:subjectController,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10),
                      child: Text(
                        'Message:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (val){
                          if(val!.isEmpty){
                            return "comment Required";
                          }
                          return null;
                        },
                        controller:commentController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(height: 20,),
                    Center(
                      child: InkWell(
                        onTap: () async{
                          hideKeyboard();
                          if(_formKey.currentState!.validate()){
                            setState((){
                              isLoading = true;
                            });
                            // final result =await  saveUserDetails(fullNameController.text,emailController.text,subjectController.text,commentController.text);

                            // if(result){
                            //   if(!mounted) return;
                            //   showSnackBar(context, 'Your Request Posted Successfully', Colors.green, Colors.white);
                            //   Navigator.pop(context);
                            // }else{
                            //   if(!mounted) return;
                            //   showSnackBar(context, 'Something Went Wrong', Colors.red, Colors.white);
                            // }
                            setState((){
                              isLoading = false;
                            });
                          }

                        },
                        child:Ink(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(244, 84, 70, 1),
                                  Color.fromRGBO(225, 42, 90, 1)
                                ]),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child:isLoading? const Center(child: CircularProgressIndicator(),): const Center(
                              child: Text("Save",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                            )
                        ),
                      ),
                    ),

                  ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
