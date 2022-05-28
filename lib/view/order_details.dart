import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:http/http.dart' as http;

import '../models/cart_response.dart';
import '../models/order_model.dart';
import '../models/user_models.dart';
import '../utils/shared_pref_funcs.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key,required this.id}) : super(key: key);
  final int id;
  @override
  State<OrderDetails> createState() => _OrderDetailsState(id);
}

class _OrderDetailsState extends State<OrderDetails> {
  _OrderDetailsState(this.id);
  final int id;
  AuthModel? authModel;
  Order? order;
  List<Items> itemList = [];
  RefreshController refreshController = RefreshController(initialRefresh: true);

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
    }else{
      if(mounted) Navigator.of(context).pop();
    }
  }
  
  Future<bool> getOrderDetails() async{
    final response =await http.get(Uri.parse("$BASE_URL$ORDER_DETAIL_END_POINT?id=$id"),
        headers: {
          "Authorization": "Token ${authModel!.token}"
        });
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      order = Order.fromJson(result['order']);
      itemList.clear();
      for(int i=0;i<result['order_items'].length;i++){
        itemList.add(Items.fromJson(result['order_items'][i]));
      }
      setState((){

      });
      statusManage((order?.status ?? ""));
      return true;
    }
    return false;
  }
  var currentStatus = 0;
  statusManage(status){
    if(status.toLowerCase()=="pending"){
      setState((){
        currentStatus = 1;
      });
    }else if(status.toLowerCase()=="processing"){
      setState((){
        currentStatus = 2;
      });
    }else if(status.toLowerCase()=="shipped"){
      setState((){
        currentStatus = 3;
      });
    }else if(status.toLowerCase()=="delivered"){
      setState((){
        currentStatus = 4;
      });
    }else{
      setState((){
        currentStatus = 0;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
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
                  height:70,
                  child: Center(child:Row(
                    children: [
                      GradientText(
                        'NEXGEN ',
                        style:const TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 30.0,
                            fontStyle: FontStyle.italic
                        ),
                        colors:const [
                          Color.fromRGBO(244, 84, 70, 1),
                          Color.fromRGBO(225, 42, 90, 1)
                        ],
                      ),
                      const SizedBox(width: 5,),
                      const Text("Shop",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),)
                    ],
                  ),)),
              const Spacer(),

            ],
          )),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async{
          final result = await getOrderDetails();
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                               const Text("Order Number",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                               Text(" ${(order?.orderId ?? "")}",style: const TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                            ],
                          ),

                        ),
                        const SizedBox(height: 5,),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 5,),
                        const Center(child: Text("Order Status",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                        const SizedBox(height: 20,),
                        Column(
                          children: [
                            TimelineTile(
                              alignment: TimelineAlign.start,
                              isFirst: true,
                              endChild: Container(
                                 margin:const EdgeInsets.only(left: 20),
                                constraints:const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      height:50,
                                      child: Image(image: AssetImage("images/orderplace.png")),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        const Text("Order Placed",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                        Text((Jiffy((order?.date ?? "2022-01-01")).yMMMMdjm),style:const TextStyle(fontStyle: FontStyle.italic),),
                                        const Text("Confirmed",style: TextStyle(color: Colors.green,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              indicatorStyle: IndicatorStyle(
                                width: 30,
                                color: Colors.green,
                                indicatorXY: 0.5,
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: Icons.offline_pin_rounded,
                                ),
                              ),
                              afterLineStyle: const LineStyle(
                                color: Colors.green,
                                thickness: 4,
                              ),

                            ),
                            TimelineTile(
                              alignment: TimelineAlign.start,
                              endChild: Container(
                                 margin:const EdgeInsets.only(left: 20),
                                constraints:const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      height:50,
                                      child: Image(image: AssetImage("images/pending.png")),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        const Text("Order In Pending",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                        currentStatus >= 1 ? const Text("Confirmed",style: TextStyle(color: Colors.green,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),):const Text("Running",style: TextStyle(color: Colors.yellow,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              indicatorStyle: IndicatorStyle(
                                width: 30,
                                color:currentStatus >=1? Colors.green: Colors.grey,
                                indicatorXY: 0.5,
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData:currentStatus >= 1 ? Icons.offline_pin_rounded : Icons.info_rounded,
                                ),
                              ),
                              afterLineStyle:  LineStyle(
                                color: currentStatus >=1? Colors.green: Colors.grey,
                                thickness: 4,
                              ),
                              beforeLineStyle:  LineStyle(
                                color: currentStatus >=1? Colors.green: Colors.grey,
                                thickness: 4,
                              ),

                            ),
                            TimelineTile(
                              alignment: TimelineAlign.start,
                              endChild: Container(
                                 margin:const EdgeInsets.only(left: 20),
                                constraints:const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      height:50,
                                      child: Image(image: AssetImage("images/process.png")),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        const Text("Order Processing",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                        currentStatus >= 2 ? const Text("Confirmed",style: TextStyle(color: Colors.green,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),):const Text("",style: TextStyle(color: Colors.yellow,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              indicatorStyle: IndicatorStyle(
                                width: 30,
                                color: currentStatus >=2? Colors.green: Colors.grey,
                                indicatorXY: 0.5,
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: currentStatus >=2? Icons.offline_pin_rounded: Icons.info_rounded,
                                ),
                              ),
                              afterLineStyle:  LineStyle(
                                color: currentStatus >=2? Colors.green: Colors.grey,
                                thickness: 4,
                              ),
                              beforeLineStyle:  LineStyle(
                                color: currentStatus >=2? Colors.green: Colors.grey,
                                thickness: 4,
                              ),

                            ),
                            TimelineTile(
                              alignment: TimelineAlign.start,
                              endChild: Container(
                                 margin:const EdgeInsets.only(left: 20),
                                constraints:const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      height:50,
                                      child: Image(image: AssetImage("images/shipped.png")),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                       const Text("Order Shipped",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                        currentStatus >= 3 ? const Text("Confirmed",style: TextStyle(color: Colors.green,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),):const Text("",style: TextStyle(color: Colors.yellow,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              indicatorStyle: IndicatorStyle(
                                width: 30,
                                color: currentStatus >=3? Colors.green: Colors.grey,
                                indicatorXY: 0.5,
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: currentStatus >=3? Icons.offline_pin_rounded: Icons.info_rounded,
                                ),
                              ),
                              afterLineStyle:  LineStyle(
                                color: currentStatus >=3? Colors.green: Colors.grey,
                                thickness: 4,
                              ),
                              beforeLineStyle:  LineStyle(
                                color: currentStatus >=3? Colors.green: Colors.grey,
                                thickness: 4,
                              ),

                            ),
                            TimelineTile(
                              alignment: TimelineAlign.start,
                                isLast: true,
                              endChild: Container(
                                 margin:const EdgeInsets.only(left: 20),
                                constraints:const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      height:50,
                                      child: Image(image: AssetImage("images/delivered.png")),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                      const  Text("Order Delivered",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                                        currentStatus >= 4 ? const Text("Confirmed",style: TextStyle(color: Colors.green,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),):const Text("",style: TextStyle(color: Colors.red,fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              indicatorStyle: IndicatorStyle(
                                width: 30,
                                color: currentStatus >=4? Colors.green: Colors.grey,
                                indicatorXY: 0.5,
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: currentStatus >=4? Icons.offline_pin_rounded: Icons.info_rounded,
                                ),
                              ),
                              afterLineStyle:  LineStyle(
                                color: currentStatus >=4? Colors.green: Colors.grey,
                                thickness: 4,
                              ),
                              beforeLineStyle:  LineStyle(
                                color: currentStatus >=4? Colors.green: Colors.grey,
                                thickness: 4,
                              ),

                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("1 Item",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                        ),
                        const Divider(thickness: 1,),
                        Column(
                          children: itemList.map((e) => Row(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Image.network("$BASE_IMAGE_URL${e.product!.product!.image}")),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(e.product!.product!.title.toString(),
                                      style:const TextStyle(
                                        fontSize: HEADING_FONT_SIZE
                                      ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                    const SizedBox(height: 5,),
                                    Text("Qty: ${e.quantity}",
                                      style:const TextStyle(
                                        fontSize: HEADING_FONT_SIZE
                                      ),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  e.size!.isNotEmpty?Row(
                                    children: [
                                      const Text("Size: ",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(" ${e.size!.toUpperCase()}",
                                          style:const TextStyle(
                                            fontSize: HEADING_FONT_SIZE,
                                            fontWeight: FontWeight.bold
                                          ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ):Container(),
                                  e.color!.isNotEmpty?Row(
                                    children: [
                                      const Text("Color: ",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(" ${e.color!.toUpperCase()}",
                                          style:const TextStyle(
                                            fontSize: HEADING_FONT_SIZE,
                                            fontWeight: FontWeight.bold
                                          ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ):Container(),
                                ],
                              )
                            ],
                          ) ).toList(),
                        )

                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("DELIVERY DETAILS",style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 5,),
                        const Text("DELIVERY ADDRESS:",style: TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        const SizedBox(height: 10,),
                        Text((authModel?.customer?.address ?? ""),style:const TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          color: HEADING_COLOR
                        ),),
                        const SizedBox(height: 10,),
                        const Text("DELIVERY CITY:",style: TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        const SizedBox(height: 10,),
                        Text(authModel?.customer?.city ?? "",style:const TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          color: HEADING_COLOR
                        ),),
                        const SizedBox(height: 10,),
                        const Text("CONTACT NO:",style: TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        const SizedBox(height: 10,),
                        Text((authModel?.customer?.mobileNo ?? ""),style:const TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          color: HEADING_COLOR
                        ),),
                        const SizedBox(height: 10,),
                        const Text("DELIVERY CHARGES:",style: TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        const SizedBox(height: 10,),
                        Text("Rs. ${(order?.shippingFee ?? "")}",style:const TextStyle(
                          fontSize: HEADING_FONT_SIZE,
                          color: HEADING_COLOR
                        ),),
                        const SizedBox(height: 10,),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("PAYMENT DETAILS:",style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 10,),
                        const Text("PAYMENT METHOD:",style: TextStyle(
                            fontSize: HEADING_FONT_SIZE,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),),
                        const SizedBox(height: 10,),
                        const Text("COD",style: TextStyle(
                            fontSize: HEADING_FONT_SIZE,
                            color: HEADING_COLOR
                        ),),
                        const SizedBox(height: 5,),
                        const SizedBox(height: 10,),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("ORDER TOTAL:",style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text("SUB-TOTAL: ",style: TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                color:HEADING_COLOR,
                              fontWeight: FontWeight.w600,

                            ),),
                            const SizedBox(width: 5,),
                             Text("Rs ${order?.totalPrice ?? ""}",style:const TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                color: HEADING_COLOR
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("SHIPPING-FEE: ",style: TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                fontWeight: FontWeight.w600,
                                color: HEADING_COLOR
                            ),),
                            const SizedBox(width: 5,),
                             Text("Rs ${order?.shippingFee ?? ""}",style:const TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                color: HEADING_COLOR
                            ),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 10,),
                        const SizedBox(width: 5,),
                        Text("TOTAL: Rs ${(order?.shippingFee ?? 0) + (order?.totalPrice ?? 0)}",style:const TextStyle(
                            fontSize: HEADING_FONT_SIZE,
                            color: HEADING_COLOR,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(width: 10,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
