import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/models/single_product_models.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/view/login.dart';
import 'package:quantum_genius/view/reviews_screen.dart';
import 'package:quantum_genius/view/add_review.dart';
import 'package:quantum_genius/widgets/footer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/user_models.dart';
import '../utils/shared_pref_funcs.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key? key,required this.id}) : super(key: key);
  final int id;
  @override
  State<SingleProduct> createState() => _SingleProduct(id);
}

class _SingleProduct extends State<SingleProduct> {
  _SingleProduct(this.id);
  final int id;

  List<String> images = [];
  List<String> sizes = [];
  List<String> colors = [];

  int currentPos = 0;
  RefreshController refreshController = RefreshController(initialRefresh: true);
  SingleProductModel? singleProductModel;
  int discounted = 0;

  Future<bool> getProduct(id) async{
    var url = Uri.parse("$BASE_URL$PRODUCT_SINGLE_END_POINT/$id");
    final response=await http.get(url);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final result = SingleProductModel.fromJson(json);
      singleProductModel = result;

      List<String> tempList = [];
      tempList.add(singleProductModel!.stock!.product!.image.toString());
      tempList.addAll(singleProductModel!.images!.map((e) => e.image.toString()).toList());
      images = tempList;
      var temp =  (singleProductModel!.stock!.salePrice! * singleProductModel!.stock!.discount!/100);
      discounted = (singleProductModel!.stock!.salePrice! - temp).floor();
      sizes.clear();
      colors.clear();
      sizes.addAll(singleProductModel!.sizes!.map((e) => e.size.toString()).toList());
      colors.addAll(singleProductModel!.colors!.map((e) => e.title.toString()).toList());
      if(colors.isNotEmpty){
        selectedColor = colors[0];
      }
      if(sizes.isNotEmpty){
        selectedSize = sizes[0];
      }
      await _asyncMethod();
      setState((){

      });
      return true;

    }
    else{
      return false;
    }
  }

  bool showVideo = false;

  String? selectedSize;
  String? selectedColor;
  bool isLoading= false;
  bool login = false;
  AuthModel? authModel;
  _asyncMethod() async {
    final result = await isLogin();
    if (result) {
      authModel = await getSession();
      setState(() {
        login = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        onRefresh: () async{
          final result = await getProduct(id);
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
        },
        controller: refreshController,
        child: SingleChildScrollView(

          child: Column(
            children: [
              showVideo?SizedBox(
                height: 400,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: singleProductModel?.stock?.product?.youtubeVideoUrl ?? '', //Add videoID.
                    flags: const YoutubePlayerFlags(
                      hideControls: false,
                      controlsVisibleAtStart: true,
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: HEADING_COLOR,
                ),
              ):Column(
                children: [
                  CarouselSlider(
                    items: images.map((e) => Container(
                      decoration: BoxDecoration(
                        image:  DecorationImage(
                          image: NetworkImage("$BASE_IMAGE_URL$e"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )).toList(),
                    //Slider Container properties
                    options: CarouselOptions(
                        height: 400.0,
                        initialPage: 0,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 500),
                        viewportFraction: 1,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentPos = index;
                          });
                        }
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.map((url) {
                      int index = images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              (singleProductModel?.stock?.product?.youtubeVideoUrl?.isNotEmpty ?? false) ? GestureDetector(
                onTap: (){
                  setState((){
                  showVideo =!showVideo;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Center(child: Text(!showVideo?"Play Video":"Close Video",style: const TextStyle(color: Colors.red),),),
                    const Center(child: Icon(Icons.play_arrow,color: Colors.red,),),
                  ],
                ),
              ):Container(),
              const Divider(
                thickness: 2,
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          singleProductModel?.stock?.product?.title ?? "..",
                          style: const TextStyle(
                              fontSize: HEADING_FONT_SIZE,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                        child: Text(
                          "By: ${singleProductModel?.stock?.product?.brand?.title?.toUpperCase().toString() ?? ".."}",
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                        child:(singleProductModel?.stock?.discount ?? 0)>0? Row(

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 1.0),
                              child: Text("Rs ${singleProductModel?.stock?.salePrice ?? ".."}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 17,
                                      color: Colors.grey[700])),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Rs $discounted",
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "(-${singleProductModel?.stock?.discount ?? "0"}%)",
                                style: const TextStyle(fontSize: HEADING_FONT_SIZE, color: Colors.red),
                              ),
                            ),


                          ],
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Rs ${singleProductModel?.stock?.salePrice ?? 0}",
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (sizes.isNotEmpty || colors.isNotEmpty) ?  SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children:  [
                                  sizes.isNotEmpty ? Row(
                                    children: [
                                      const Text("Select Size: ",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                                      const SizedBox(width: 10,),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme
                                                  .of(context)
                                                  .hintColor,
                                            ),
                                          ),
                                          items: sizes
                                              .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item.toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: HEADING_FONT_SIZE,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                          value: selectedSize,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSize = value as String;
                                            });
                                            print(selectedSize);
                                          },
                                          buttonHeight: 40,
                                          itemHeight: 40,
                                        ),
                                      ),
                                    ],
                                  ):Container(),
                                  const Spacer(),
                                  colors.isNotEmpty ?
                                  Row(
                                    children: [
                                      const Text("Select Color: ",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                                      const SizedBox(width: 10,),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme
                                                  .of(context)
                                                  .hintColor,
                                            ),
                                          ),
                                          items: colors
                                              .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontSize: HEADING_FONT_SIZE,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                          value: selectedColor,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedColor = value as String;
                                            });
                                            print(selectedColor);
                                          },
                                          buttonHeight: 40,
                                          buttonWidth: 100,

                                          itemHeight: 40,
                                        ),
                                      )
                                    ],
                                  ):Container()
                                ],
                              ),
                            )),
                      ):Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      (singleProductModel?.stock?.quantity ?? 0) > 0?
                      Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(onPressed: (){
                              showSnackBar("Item Added In WishList", Colors.green, Colors.white);
                            },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.45,45)),
                                  maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.45,45)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          side: BorderSide(color: ORANGE_COLOR)
                                      )
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.favorite_border_outlined,color: ORANGE_COLOR,),
                                  SizedBox(width: 10,),
                                  Text("WHISHLIST",style: TextStyle(
                                      color: ORANGE_COLOR,
                                      fontSize: HEADING_FONT_SIZE
                                  ))
                                ],
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: _addToCart,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(ORANGE_COLOR),
                                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.49,45)),
                                  maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.49,45)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          side: BorderSide(color: ORANGE_COLOR)
                                      )
                                  )),
                              child:!isLoading? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("ADD TO BAG",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: HEADING_FONT_SIZE
                                  ),)
                                ],
                              ):const Center(child: CircularProgressIndicator(color: Colors.white,),),
                            ),
                            const Spacer(),
                          ],
                        ),): const Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 8.0),
                        child: Text(
                          "OUT OF STOCK",
                          style: TextStyle(color: ORANGE_COLOR, fontWeight: FontWeight.bold,fontSize: HEADING_FONT_SIZE),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              ExpansionTile(
                tilePadding:const EdgeInsets.symmetric(horizontal: 10),
                title:const Text("Product Description",style: TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR),),
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(singleProductModel?.stock?.product?.title ?? "")
                      )
                  )
                ],
              ),
              const Divider(thickness: 1),
              Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, left: 15.0,),
                        child: Text(
                          "Delivery Time",
                          style: TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          const Image(image: AssetImage("images/bus1.jpg"),width: 50,height: 50,),
                          Flexible(
                            child: Text(
                              "Shipment will take 3-5 days after confirmation of the order.",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[700]),
                            ),
                          )
                         ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 132,
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                          EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            "Customer Reviews & Rating",
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 16.0, left: 8.0),
                          child: Row(
                            children: [
                               Text(getRatings(singleProductModel?.reviews ?? []).toStringAsFixed(1)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: getRatings(singleProductModel?.reviews ?? []),
                                    minRating: 1,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {

                                    },
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Based on ${singleProductModel?.reviews?.length} review",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ReviewScreen(reviewList: singleProductModel?.reviews ?? [])));
                    },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.45,40)),
                          maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.45,40)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  side: BorderSide(color: ORANGE_COLOR)
                              )
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.reviews,color: ORANGE_COLOR,),
                          SizedBox(width: 10,),
                          Text("See All",style: TextStyle(
                              color: ORANGE_COLOR,
                              fontSize: HEADING_FONT_SIZE
                          ))
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(onPressed: (){
                      if(!login){
                        showSnackBar("Please Login First",Colors.red,Colors.white);
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const Login()));
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddReviewScreen(stockId: singleProductModel?.stock?.id?.toInt() ?? 0,)));
                      }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ORANGE_COLOR),
                          minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.49,40)),
                          maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.49,40)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  side: BorderSide(color: ORANGE_COLOR)
                              )
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.rate_review,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text("ADD Your Review",style: TextStyle(
                              color: Colors.white,
                              fontSize: HEADING_FONT_SIZE
                          ),)
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),),
              const Divider(thickness: 2,),
              const FooterExpansion()

            ],
          ),
        ),
      ),
    );
  }
  getRatings(List<Reviews> list){
    if (list.isEmpty){
      return 5.0;
    }
    var rat = 0;
    for(int i=0;i<list.length;i++){
      rat += list[i].rating!;
    }
    var result = rat/list.length;
    return (result>0?result:0.0);
  }
  void _addToCart() async{
    if(!login){
      showSnackBar("Please Login First",Colors.yellow,HEADING_COLOR);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const Login()));
    }
    else if(sizes.isNotEmpty && selectedSize==null){
      showSnackBar("Size Select First",Colors.yellow,HEADING_COLOR);
      return;
    }else if(colors.isNotEmpty && selectedColor==null){
      showSnackBar("Color Select First",Colors.yellow,HEADING_COLOR);
      return;
    }else{
      setState((){
        isLoading = true;
      });
      final result =await addItemToCart(singleProductModel!.stock!.id!.toInt(), 1, selectedSize, selectedColor, authModel!.customer!.id!.toInt());
      if(!result['error']){
        showSnackBar("Item Added To Cart",Colors.green,Colors.white);

      }else{
        showSnackBar(result['message'],Colors.red,Colors.white);
      }
      setState((){
        isLoading = false;
      });
    }


  }
  showSnackBar(text,color,textColor){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text,style: TextStyle(color: textColor),),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1000),
    ));
  }

  Future<Map<dynamic,dynamic>> addItemToCart(int stockId,int quantity,String? size,String? color,int customerId) async{
    var map = <dynamic,dynamic>{};
    map['stock_id'] = stockId.toString();
    map['quantity'] = quantity.toString();
    map['size'] = size ?? "";
    map['color'] = color ?? "";
    map['customer_id'] = customerId.toString();
    print(map);

    final response = await http.post(
      Uri.parse('$BASE_URL$ADD_TO_CART_END_POINT'),
      headers: {
        "Authorization": "Token ${authModel!.token.toString()}"
      },
      body: map,
    );
    final res = jsonDecode(response.body);
    if(response.statusCode==200){
      return res;
    }
    return {
      'error':true,
      'message':"something went wrong"
    };
  }
}
