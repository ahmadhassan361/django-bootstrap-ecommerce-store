import 'dart:convert';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/functions.dart';
import 'package:quantum_genius/view/order_details.dart';

import '../models/order_model.dart';
import '../models/user_models.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_funcs.dart';
class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  var selectedValue = "";
  RefreshController refreshController = RefreshController(initialRefresh: true);
  bool login = false;
  AuthModel? authModel;
  List<Order> orderList = [];
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
        login = true;
      });
    }else{
      if(mounted) Navigator.of(context).pop();
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
        title: const Text("My Orders",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async{
          final result = await getMyOrders(selectedValue);
          if(result){
            refreshController.refreshCompleted();
          }else{
            if(mounted) showSnackBar(context, "Something Went Wrong", Colors.red, Colors.white);
            refreshController.refreshFailed();
          }
          },
        child: Column(
          children:  [
            Container(
              height: 70,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:  [
                  GestureDetector(
                    onTap: (){
                      _filterOrders("");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("All",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("pending");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Pending",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("processing");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Processing",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("shipped");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Shipped",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("delivered");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Delivered",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("cancelled");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Cancelled",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),GestureDetector(
                    onTap: (){
                      _filterOrders("rejected");
                    },
                    child:const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(label: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 5),
                        child: Text("Rejected",style: TextStyle(color: HEADING_COLOR,fontSize: HEADING_FONT_SIZE),),
                      ),backgroundColor: BACKGROUND_COLOR,),
                    ),
                  ),



                ],
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text('${selectedValue.isEmpty ?"All":selectedValue.toUpperCase()} ORDERS',style:const TextStyle(fontSize: BIG_HEADING_FONT_SIZE,color: HEADING_COLOR),),
              ),
            ),
            const SizedBox(height:20),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  itemCount: orderList.length,
                  itemBuilder: (context,index){
                  Order item = orderList[index];
                  var color = (item.status!.toLowerCase() == "rejected" || item.status!.toLowerCase() == "cancelled" ? Colors.red:Colors.green);
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              SizedBox(
                                width:MediaQuery.of(context).size.width*0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Order Number",style: TextStyle(color: HEADING_COLOR),),
                                    const SizedBox(height: 2,),
                                    Text("${item.orderId}",style:const  TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR,fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 5,),
                                    Text(Jiffy(item.date).yMMMMdjm,style:const  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontStyle: FontStyle.italic),),
                                    const SizedBox(height: 5,),
                                    Text(item.status!.toUpperCase(),style:  TextStyle(fontSize: HEADING_FONT_SIZE,color: color,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              const VerticalDivider(thickness: 2,),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Order Price",style: TextStyle(color: HEADING_COLOR),),
                                  const  SizedBox(height: 2,),
                                  Text("Rs. ${item.totalPrice! + item.shippingFee!.toInt()}",style:const TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR,fontWeight: FontWeight.bold),),
                                  const  Spacer(),
                                  InkWell(
                                    onTap: () async{
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetails(id:item.id!.toInt())));
                                    },

                                    child:Ink(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(colors: [
                                              Color.fromRGBO(244, 84, 70, 1),
                                              Color.fromRGBO(225, 42, 90, 1)
                                            ]),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                            child: Text("View Details",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );

  }

  Future<bool> getMyOrders(filter) async{
    final response =await http.get(Uri.parse("$BASE_URL$MY_ORDERS_END_POINT?customer_id=${authModel!.customer!.id}&filter=$filter"),
        headers: {
          "Authorization": "Token ${authModel!.token}"
        }
        );
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      print(result);
      orderList.clear();
      for(int i=0;i<result.length;i++){
        orderList.add(Order.fromJson(result[i]));
      }
      setState((){

      });
      return true;
    }
    return false;
  }
   _filterOrders(value) {
    setState((){
      selectedValue = value;
    });
    refreshController.requestRefresh();
  }
}
