import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:quantum_genius/models/user_models.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:quantum_genius/utils/functions.dart';
import 'package:quantum_genius/utils/shared_pref_funcs.dart';
import 'package:quantum_genius/view/main_screen.dart';
import 'package:quantum_genius/view/signup.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoints.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.isSignUp = false}) : super(key: key);
  final bool isSignUp;

  @override
  _LoginState createState() => _LoginState(isSignUp);

}

class _LoginState extends State<Login> {
  _LoginState(this.isSignUp);
  //Attributes
  final bool isSignUp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;
  //Login Function
  Future<bool> loginUser(email,pass) async {
    final  response = await http.post(Uri.parse("$BASE_URL$LOGIN_END_POINT"),
      body: {
        'username':email,
        'password':pass,
      },
    );
    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      AuthModel authModel = AuthModel.fromJson(responseData);
      await setSession(authModel);
      await setLogin();
      return true;
    }
    else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    if(isSignUp){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Activation Link Has Been Sent To Your Email\nPlease Verify Your Email"),
        duration: Duration(milliseconds: 10000),
      ));
    }
  }

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'WELCOME BACK',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Sing In To Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(

                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [

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
                              Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {

                                    },
                                    child: const Text(
                                      'forgot password?',
                                      style: TextStyle(color: HEADING_COLOR,fontSize: 14),
                                    ),
                                  ),
                                ],
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
                                        isLoading = !isLoading;
                                      });
                                      await loginUser(emailController.text, passwordController.text).then((value) => {
                                        if(value){
                                            showSnackBar(context, "Welcome Back!", Colors.green, Colors.white),
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const MainScreen()),(route) => false,)
                                        }else{
                                          setState((){
                                            isLoading = !isLoading;
                                          }),
                                          showSnackBar(context, "Invalid Credentials", Colors.red, Colors.white)
                                        }
                                      });
                                    }
                                  },
                                  child:isLoading?const CircularProgressIndicator(color: Colors.white,): const Text('LOG IN',style: TextStyle(color: Colors.white,fontSize: HEADING_FONT_SIZE),)),
                            ],
                          )),
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SignUp()));
                        },
                        child: const Text(
                          'Not have an account? Signup',
                          style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),
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