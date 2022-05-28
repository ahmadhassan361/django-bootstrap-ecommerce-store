import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/functions.dart';
import 'package:quantum_genius/view/login.dart';
import '../utils/colors.dart';
import '../utils/fontsize.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  //Function of CreateUser
  Future<Map<dynamic,dynamic>> registerUser(name,email,pass1,pass2) async{
    final  response = await http.post(Uri.parse("$BASE_URL$CREATEUSER_END_POINT"),
                                        body: {
                                          'fullname': name,
                                          'email':email,
                                          'password1':pass1,
                                          'password2':pass2
                                        },
                                      );
    print(response.body);
    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      return responseData;
    }
    else {
      return {
        'error':true,
        'message':'something went wrong'
      };
    }



  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 var fullNameController = TextEditingController();
 var emailController = TextEditingController();
 var passwordController = TextEditingController();
 var cPasswordController = TextEditingController();

 bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(

            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height*1,
                  width: MediaQuery.of(context).size.width*1,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color.fromRGBO(244, 84, 70, 1), Color.fromRGBO(225, 42, 90, 1)])

                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*1,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'SIGN UP',
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            color: Colors.white,
                            fontSize: 40.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullNameController,
                              validator: (value){
                                  if(value!.isEmpty || value.length<5){
                                    return 'Enter Valid Name';
                                  }
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor:Colors.white54,
                              style:const TextStyle(color: Colors.white),
                              decoration: InputDecoration(

                                labelText: 'FullName',
                                labelStyle: const TextStyle(
                                    color:  Colors.white54
                                ),
                                fillColor: Colors.white10,
                                prefixIcon: const Icon(Icons.person,color: Colors.white54,),

                                prefixStyle: const TextStyle(
                                    color: Colors.white54
                                ),
                                prefixIconColor: Colors.white54,

                                filled: true,
                                focusColor: Colors.white54,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabled: true,
                                  errorStyle:const TextStyle(
                                      color: Colors.white
                                  )
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: emailController,
                              validator: (value){
                                if(!EmailValidator.validate(value!)){
                                  return 'Enter Valid Email';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor:Colors.white54,
                              style:const TextStyle(color: Colors.white),
                              decoration: InputDecoration(

                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                    color:  Colors.white54
                                ),
                                fillColor: Colors.white10,
                                prefixIcon: const Icon(Icons.email_outlined,color: Colors.white54,),

                                prefixStyle: const TextStyle(
                                    color: Colors.white54
                                ),
                                prefixIconColor: Colors.white54,

                                filled: true,
                                focusColor: Colors.white54,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabled: true,
                                  errorStyle:const TextStyle(
                                      color: Colors.white
                                  )
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: passwordController,
                              validator: (value){
                                if(value!.length < 8 || value.isEmpty){
                                  return 'password must be 8 or more chars';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor:Colors.white54,
                              style:const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(

                                labelText: 'Password',

                                labelStyle: const TextStyle(
                                    color:  Colors.white54
                                ),
                                prefixIcon: const Icon(Icons.lock_open_outlined,color: Colors.white54,),

                                prefixStyle: const TextStyle(
                                    color: Colors.white54
                                ),
                                prefixIconColor: Colors.white54,
                                fillColor: Colors.white10,
                                filled: true,
                                focusColor: Colors.white54,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white30,width: 1)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.white,width: 2)
                                  ),
                                  enabled: true,
                                  errorStyle:const TextStyle(
                                      color: Colors.white
                                  )
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: cPasswordController,
                              validator: (value){
                                if(value!.length < 8 || value.isEmpty){
                                  return 'password must be 8 or more chars';
                                }else if(value != passwordController.text){
                                  return 'password does not match';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor:Colors.white54,
                              style:const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(

                                labelText: 'Confirm Password',

                                labelStyle: const TextStyle(
                                    color:  Colors.white54
                                ),
                                prefixIcon: const Icon(Icons.lock_open_outlined,color: Colors.white54,),

                                prefixStyle: const TextStyle(
                                    color: Colors.white54
                                ),
                                prefixIconColor: Colors.white54,
                                fillColor: Colors.white10,
                                filled: true,
                                focusColor: Colors.white54,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white,width: 2)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white30,width: 1)
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white30,width: 1)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: Colors.white,width: 2)
                                ),
                                enabled: true,
                                errorStyle:const TextStyle(
                                  color: Colors.white
                                )
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  maximumSize:  Size(MediaQuery.of(context).size.width*1, 55.0),
                                  minimumSize: Size(MediaQuery.of(context).size.width*1, 55.0),
                                  primary: HEADING_COLOR,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async{
                                  hideKeyboard();
                                  if(_formKey.currentState!.validate()){
                                    setState((){
                                      isLoading = true;
                                    });
                                    await registerUser(fullNameController.text,emailController.text,passwordController.text,cPasswordController.text)
                                        .then((value) => {
                                      if(!value['error']){
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>const Login(isSignUp: true,)),(route) => false,),
                                          showSnackBar(context, value['message'], Colors.green, Colors.white)
                                      }else{
                                        showSnackBar(context, value['message'], Colors.green, Colors.white)
                                      }
                                    });
                                    setState((){
                                      isLoading = false;
                                    });
                                  }
                                },
                                
                                child:isLoading?const CircularProgressIndicator(color: Colors.white,): const Text('SIGN UP',style: TextStyle(fontSize: HEADING_FONT_SIZE),)),
                          ],
                    )),

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Already have account? Login',
                        style: TextStyle(color: HEADING_COLOR,fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}