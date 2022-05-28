import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import '../models/faq_model.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<FAQ> faqList = [];
  Future<bool> getFaq()async{
    final response =await  http.get(Uri.parse("$BASE_URL$GET_FAQ_END_POINT"));
    if(response.statusCode==200){
      final result= jsonDecode(response.body);
      faqList.clear();
      for(int i=0;i<result.length;i++){
        faqList.add(FAQ.fromJson(result[i]));
      }
      setState((){

      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          // The search area here
          title: Row(
            children: [
              SizedBox(
                  height: 70,
                  child: Center(child: Row(
                    children: [
                      GradientText(
                        'NEXGEN ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0,
                            fontStyle: FontStyle.italic
                        ),
                        colors: const [
                          Color.fromRGBO(244, 84, 70, 1),
                          Color.fromRGBO(225, 42, 90, 1)
                        ],
                      ),
                      const SizedBox(width: 5,),
                      const Text("Shop", style: TextStyle(fontSize: 28,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),)
                    ],
                  ),)),
              const Spacer(),

            ],
          )),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async{
          final result = await getFaq();
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }

        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Center(child:  Text("Frequently Asked Questions", style: TextStyle(
                        fontSize: BIG_HEADING_FONT_SIZE,
                        fontWeight: FontWeight.bold,
                        color: HEADING_COLOR),)),
                    const SizedBox(height: 20,),
                   Column(
                     children: faqList.map((e) =>  ExpansionTile(
                       title: Text(e.question ?? "",style:const TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR)),children: [
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Text(e.answer ?? "",style:const TextStyle(color: HEADING_COLOR),),
                       )
                     ],)).toList(),
                   )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
