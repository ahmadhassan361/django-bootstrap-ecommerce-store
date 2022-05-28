import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/models/cart_response.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/functions.dart';
import 'package:quantum_genius/view/single_product_screen.dart';
import 'package:quantum_genius/widgets/footer.dart';
import 'package:http/http.dart' as http;
import '../models/user_models.dart';
import '../utils/endpoints.dart';
import '../utils/fontsize.dart';
import '../utils/shared_pref_funcs.dart';
import 'checkout_customer_details.dart';
import 'login.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart>  {
  // @override
  // bool get wantKeepAlive => true;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  CartResponse? cartResponse;

  bool login = false;
  AuthModel? authModel;
  bool isLoading = false;


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
    }
  }

  List<int> quantities = [];

  Future<bool> getCartItems() async{
    var url = Uri.parse("$BASE_URL$GET_CART_ITEMS_END_POINT?id=${authModel?.customer?.id}");
    final response =await http.get(
        url,
        headers: {
        "Authorization": "Token ${authModel!.token}"
        }
    );
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      cartResponse = CartResponse.fromJson(result);
      if(cartResponse!.items!.isNotEmpty){
        quantities.clear();
        quantities.addAll(cartResponse!.items!.map((e) => e.quantity!.toInt()).toList());
      }

      setState((){

      });
      if(result['error']){
        return false;
      }
      return true;
    }else{
      return false;
    }
  }
  Future<Map<dynamic,dynamic>> placeOrder(customerId,subtotal,shipping) async{
    Map<dynamic,dynamic> map = {
      'customer_id':customerId.toString(),
      'sub_total':subtotal.toString(),
      'shipping':shipping.toString()
    };
    final response =await http.post(Uri.parse("$BASE_URL$PLACE_ORDER_END_POINT"),
        headers: {
          "Authorization": "Token ${authModel!.token}",
        },
        body: map
    );
    if(response.statusCode == 200){
    var  result = jsonDecode(response.body);
    print(result);
      return result;
    }
    return {
      'error':true,
      'message':"something went wrong"
    };
  }
  Future<Map<dynamic,dynamic>> updateItem(itemId,quantity) async{
    Map<dynamic,dynamic> map = {
      'item_id':itemId.toString(),
      'updated_quantity':quantity.toString(),
    };
    final response =await http.post(Uri.parse("$BASE_URL$UPDATE_ITEM_END_POINT"),
        headers: {
          "Authorization": "Token ${authModel!.token}",
        },
        body: map
    );
    if(response.statusCode == 200){
    var  result = jsonDecode(response.body);
      print(result);
      return result;
    }
    return {
      'error':true,
      'message':"something went wrong"
    };
  }
  Future<Map<dynamic,dynamic>> removeItem(itemId) async{
    Map<dynamic,dynamic> map = {
      'item_id':itemId.toString(),
    };
    final response =await http.post(Uri.parse("$BASE_URL$REMOVE_ITEM_END_POINT"),
        headers: {
          "Authorization": "Token ${authModel!.token}",
        },
        body: map
    );
    if(response.statusCode == 200){
    var  result = jsonDecode(response.body);
      print(result);
      return result;
    }
    return {
      'error':true,
      'message':"something went wrong"
    };
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: login?SmartRefresher(
        controller: refreshController,
        onRefresh: () async{
          var result = await getCartItems();
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshCompleted();
          }
          },
        child: SingleChildScrollView(
          child:(cartResponse) != null?
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text(
                      "MY BAG",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: const Text(
                          "Items are reserved for 60 minutes",
                          style: TextStyle(fontSize: 14),
                        ))
                  ],
                ),
              ),
              cartResponse!.items!.isNotEmpty ? ListView.builder(
                  itemCount: cartResponse!.items!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var items = cartResponse!.items![index];
                    var temp =  (items.product!.salePrice! * items.product!.discount!/100);
                    var discounted = (items.product!.salePrice! - temp).floor();

                    return Card(
                      elevation: 2,
                      child: Stack(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SingleProduct(id: items.product!.id!.toInt())));
                                    },
                                    child: SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.25,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Image.network("$BASE_IMAGE_URL${items.product!.product!.image}")),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width *
                                                  0.6,
                                              child:  Text(items.product!.product!.title.toString(),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          IconButton(
                                              onPressed: () async{
                                                setState((){
                                                  isLoading = true;
                                                });
                                                final result =await removeItem(items.id);
                                                setState((){
                                                  isLoading = false;
                                                });
                                                if(!result['error']){
                                                  if(mounted) showSnackBar(context, result['message'], Colors.green, Colors.white);
                                                  refreshController.requestRefresh();
                                                }else{
                                                  if(mounted) showSnackBar(context, result['message'], Colors.green, Colors.white);

                                                }


                                              },
                                              icon: const Icon(Icons.cancel)),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text("Rs $discounted",
                                              style: const TextStyle(
                                                  fontSize: HEADING_FONT_SIZE,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 20,),
                                          const Text("| Qty",
                                              style:  TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          TextButton(
                                              style: TextButton.styleFrom(primary: Colors.black,backgroundColor: Colors.grey[300],minimumSize: const Size(30, 30),
                                                maximumSize: const Size(30, 30),),
                                              onPressed: () async{
                                                if(quantities[index] > 1){
                                                  setState((){
                                                    quantities[index] -=1;
                                                    isLoading = true;
                                                  });
                                                  final result = await updateItem(items.id,quantities[index]);
                                                  if(!result['error']){
                                                    if(mounted) showSnackBar(context, result['message'], Colors.green, Colors.white);
                                                  }else{
                                                    if(mounted) showSnackBar(context, result['message'], Colors.red, Colors.white);
                                                  }
                                                  setState((){
                                                    isLoading = false;
                                                  });
                                                }

                                              }, child:const Text('-',style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                          const SizedBox(width: 10,),
                                          Text("${quantities[index]}",
                                              style:const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 10,),
                                          TextButton(
                                              style: TextButton.styleFrom(primary: Colors.black,backgroundColor: Colors.grey[300],minimumSize: const Size(30, 30),
                                                maximumSize: const Size(30, 30),),
                                              onPressed: () async{
                                                setState((){
                                                  quantities[index] +=1;
                                                  isLoading = true;
                                                });
                                                final result = await updateItem(items.id,quantities[index]);
                                                if(!result['error']){
                                                  if(mounted) showSnackBar(context, result['message'], Colors.green, Colors.white);
                                                }
                                                setState((){
                                                  isLoading = false;
                                                });
                                              }, child:const Text('+',style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          items.size!.isNotEmpty?
                                          Row(
                                            children: [
                                              Text(
                                                "Size:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700]),
                                              ),
                                              Text(
                                                " ${items.size!.toUpperCase()}",
                                                style:const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ):Container(),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          items.color!.isNotEmpty?Row(
                                            children: [
                                              Text(
                                                "Color:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700]),
                                              ),
                                              Text(
                                                " ${items.color!.toUpperCase()}",
                                                style:const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ):Container(),

                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]
                      ),
                    );
                  }):
              const SizedBox(
                  height: 100,
                  child: Center(
                    child:  Text(
                      "No Items",
                      style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold),
                    ),
                  )),
              cartResponse!.items!.isNotEmpty ?Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children:  [
                              const Text(
                                "Subtotal",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "Rs. ${cartResponse!.price}",
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children:  [
                              const Text(
                                "Shipping Charges",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "Rs. ${cartResponse!.shippingCharges}",
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children:  [
                              const Text(
                                "Grand Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const  Spacer(),
                              Text(
                                "Rs. ${cartResponse!.price! + cartResponse!.shippingCharges!.toDouble()}",
                                style:const  TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            if(!isLoading){
                              setState((){
                                isLoading = true;
                              });
                              if(authModel!.customer!.mobileNo!.isEmpty ||  authModel!.customer!.city!.isEmpty || authModel!.customer!.province!.isEmpty
                              || authModel!.customer!.zipcode!.isEmpty || authModel!.customer!.address!.isEmpty){
                                showSnackBar(context, "Please Add All The Information", Colors.red, Colors.white);
                                setState((){
                                  isLoading = false;
                                });
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (_)=>const CheckoutCustomerDetails()));
                                if(result){
                                  await _asyncMethod();
                                  if(mounted) showSnackBar(context, "Details Updated! Now You Can CheckOut", Colors.green, Colors.white);
                                }else{
                                  if(mounted) showSnackBar(context, "Contact Details Required", Colors.red, Colors.white);
                                }
                              }else{
                                final result = await placeOrder(authModel!.customer!.id, cartResponse!.price, cartResponse!.shippingCharges);
                                if(result['error']){
                                  if(!mounted) return;
                                  showSnackBar(context,result['message'] , Colors.red, Colors.white);
                                }else{
                                  if(!mounted) return;
                                  showSnackBar(context,result['message'] , Colors.green, Colors.white);
                                  refreshController.requestRefresh();
                                }
                              }
                              setState((){
                                isLoading = false;
                              });
                            }

                          },
                          child:Ink(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 1,
                              decoration:const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(244, 84, 70, 1),
                                    Color.fromRGBO(225, 42, 90, 1)
                                  ]),
                              ),
                              child:  Center(
                                child:isLoading?const CircularProgressIndicator(color: Colors.white,) :const Text("CHECKOUT",style: TextStyle(fontSize: HEADING_FONT_SIZE,fontWeight: FontWeight.bold),),
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ):Container(),
              const FooterExpansion(),
              const SizedBox(
                height: 50,
              ),
            ],
          ):
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(children: [
                      const Text(
                        "MY BAG",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text(
                            "Items are reserved for 60 minutes",
                            style: TextStyle(fontSize: 14),
                          )),
                    ],),
                    const SizedBox(
                      height: 500,
                        child: Center(
                          child:  Text(
                            "No Items",
                            style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ):SizedBox(
          width: MediaQuery.of(context).size.width*1,
          height: MediaQuery.of(context).size.height*1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("MY CART",style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,fontWeight: FontWeight.bold,color: HEADING_COLOR),),
              const SizedBox(height: 20,),
              const Text("Please Login First To Access Your Cart",style: TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR),),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const Login()));
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize:  const Size(100, 55.0),
                    primary: Colors.grey,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("SIGN IN" ,style: TextStyle(fontSize: HEADING_FONT_SIZE,color: Colors.white,fontWeight: FontWeight.bold),))
            ],
          )),
    );
  }

}
