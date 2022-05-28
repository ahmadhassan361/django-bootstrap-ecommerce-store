import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quantum_genius/models/user_models.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/functions.dart';
import '../utils/fontsize.dart';
import 'package:quantum_genius/utils/shared_pref_funcs.dart';
import 'package:http/http.dart' as http;

class CheckoutCustomerDetails extends StatefulWidget {
  const CheckoutCustomerDetails({Key? key}) : super(key: key);

  @override
  State<CheckoutCustomerDetails> createState() => _CheckoutCustomerDetailsState();
}

class _CheckoutCustomerDetailsState extends State<CheckoutCustomerDetails> {
  var fullNameController = TextEditingController();
  var mobileController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var zipcodeController = TextEditingController();
  var provinceController = TextEditingController();
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final result = await isLogin();
    if (result) {
      authModel = await getSession();
      setState(() {
        fullNameController.text = authModel?.customer?.fullname ?? "";
        mobileController.text = authModel?.customer?.mobileNo ?? "";
        addressController.text = authModel?.customer?.address ?? "";
        cityController.text = authModel?.customer?.city ?? "";
        zipcodeController.text = authModel?.customer?.zipcode ?? "";
        provinceController.text = authModel?.customer?.province ?? "";
        emailController.text = authModel?.customer?.user?.email ?? "";
      });
    }
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
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children:  [
                          CircleAvatar(
                            minRadius: 50,
                            backgroundColor: HEADING_COLOR,
                            child: Center(
                              child: Text(
                                authModel?.customer?.fullname?.substring(0,1).toUpperCase() ?? "",
                                style:const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            authModel?.customer?.fullname?.toUpperCase() ?? "No Name",
                            style: const TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                        textInputAction: TextInputAction.next,
                        controller:emailController,
                        enabled: false,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 5.0,left: 10),
                          child: Text(
                            'MOBILE NUMBER:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (val){
                          if(val!.isEmpty){
                            return "Mobile No Required";
                          }
                          return null;
                        },
                        controller:mobileController,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'ZIP CODE:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return "Zip Code Required";
                                    }
                                    return null;
                                  },
                                  controller:zipcodeController,
                                  textInputAction: TextInputAction.next,

                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.6,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'CITY:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return "City Required";
                                    }
                                    return null;
                                  },
                                  controller:cityController,
                                  textInputAction: TextInputAction.next,

                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    const Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10),
                      child: Text(
                        'Province:',
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
                            return "Province Required";
                          }
                          return null;
                        },
                        controller:provinceController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                          ),
                        ),

                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10),
                      child: Text(
                        'Complete Address:',
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
                            return "Address Required";
                          }
                          return null;
                        },
                        controller:addressController,
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
                            final result =await  saveUserDetails(authModel!.customer!.id,fullNameController.text,mobileController.text,addressController.text,cityController.text,zipcodeController.text,provinceController.text);

                            if(result){
                              authModel!.customer!.province = provinceController.text;
                              authModel!.customer!.city = cityController.text;
                              authModel!.customer!.fullname = fullNameController.text;
                              authModel!.customer!.mobileNo = mobileController.text;
                              authModel!.customer!.address = addressController.text;
                              authModel!.customer!.zipcode = zipcodeController.text;
                              await setSession(authModel!);
                              if(mounted) Navigator.pop(context,true);
                            }else{
                              if(!mounted) return;
                              showSnackBar(context, 'Something Went Wrong', Colors.red, Colors.white);
                            }
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
