import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/functions.dart';
import '../models/user_models.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_funcs.dart';
class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key,required this.stockId}) : super(key: key);

  final int stockId;
  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState(stockId);
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  _AddReviewScreenState(this.stockId);
  final int stockId;
  var commentController = TextEditingController();
  var rating = 5.0;
  AuthModel? authModel;
  bool isLoading = false;


  Future<Map<dynamic,dynamic>> addReview(rating,review,stockId) async{
    Map<dynamic,dynamic> map = {
      'rate':rating.toString(),
      'review':review,
      'stock':stockId.toString(),
      'customer_id':authModel?.customer?.id.toString()
    };
    final response =await http.post(Uri.parse("$BASE_URL$ADD_REVIEW_END_POINT"),
        headers: {
          "Authorization": "Token ${authModel!.token}",
        },
        body: map
    );
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    return {
      'error':true,
      'message':'something went wrong'
    };

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
            color: HEADING_COLOR
        ),
        title: const Text("Add Review",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Rate The Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: HEADING_FONT_SIZE,
                      color: HEADING_COLOR,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  RatingBar.builder(
                    initialRating: 5.0,
                    minRating: 1,
                    itemSize: 40,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                    const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rat) {
                      setState((){
                      rating = rat;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Divider(height: 5,),
              const Padding(
                padding: EdgeInsets.only(top: 20.0,left: 10),
                child: Text(
                  'Write a Comment:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  validator: (val){
                    if(val!.isEmpty){
                      return "Comment Required";
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
                    setState((){
                      isLoading = true;
                    });
                    if(stockId!=0){
                      final result = await addReview(rating, commentController.text, stockId);
                      if(result['error']){
                        if(mounted) showSnackBar(context, result['message'], Colors.red, Colors.white);
                      }else
                      {
                        if(mounted) showSnackBar(context, result['message'], Colors.green, Colors.white);
                        if(mounted) Navigator.pop(context);
                      }
                    }

                    setState((){
                      isLoading = false;
                    });
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
                    child:  Center(
                      child:isLoading?const CircularProgressIndicator(color: Colors.white,):const Text("Submit",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                    )
                  ),
                ),
              )

            ],),
        ),
      ),
    );
  }
}
