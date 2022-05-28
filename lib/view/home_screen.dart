import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantum_genius/models/homemodels.dart';
import 'package:quantum_genius/models/stock_model.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:quantum_genius/view/shopping_screen.dart';
import 'package:quantum_genius/view/single_product_screen.dart';
import 'package:quantum_genius/view_model/home_data_viewmodel.dart';
import 'package:quantum_genius/widgets/footer.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  HomeDataViewModel homeDataViewModel = HomeDataViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        extendBody: true,
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      FutureBuilder(
                        future: homeDataViewModel.getHomeData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SingleChildScrollView(
                              child: Shimmer.fromColors(
                                  baseColor: BACKGROUND_COLOR,
                                  highlightColor: BACKGROUND_COLOR_LOADING,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 110,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor:
                                                BACKGROUND_COLOR_LOADING,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Container(
                                        height: 300,
                                        color: BACKGROUND_COLOR,
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(

                                        children: [
                                          const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),

                                        ],
                                      ),
                                      const SizedBox(height: 10,),Row(

                                        children: [
                                          const  Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const  Spacer(), const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),

                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(

                                        children: [
                                          const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(), const Spacer(),
                                          Container(
                                            height: 200,
                                            color: BACKGROUND_COLOR,
                                            width: MediaQuery.of(context).size.width*0.3,
                                          ),
                                          const Spacer(),

                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  )),
                            );
                          } else {
                            List<MainCategoryHomeModel>? categoryList =
                                homeDataViewModel.homeModel!.categories;
                            List<SubCategoryHomeModel>? subCategoryList =
                                homeDataViewModel.homeModel!.subcat;
                            List<BrandHomeModel>? brandList =
                                homeDataViewModel.homeModel!.brand;
                            List<SliderModel>? sliderList =
                                homeDataViewModel.homeModel!.slider;
                            List<OfferHomeModel>? offerList =
                                homeDataViewModel.homeModel!.offer;
                            List<StockModel>? bestSellerList =
                                homeDataViewModel.homeModel!.bestSellers;
                            List<StockModel>? productList =
                                homeDataViewModel.homeModel!.productList;
                            return Column(children: [
                              SizedBox(
                                height: 110,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryList!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ShoppingScreen(
                                                      title: categoryList[index]
                                                          .title
                                                          .toString(),
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "$BASE_IMAGE_URL${categoryList[index].image}"),
                                              radius: 40,
                                              backgroundColor:
                                                  BACKGROUND_COLOR_LOADING,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${categoryList[index].title}",
                                              style: const TextStyle(
                                                  color: HEADING_COLOR,
                                                  fontSize: TEXT_FONT_SIZE),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              //-------Carousal Slider------------
                              CarouselSlider(
                                items: sliderList!
                                    .map((e) => Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                decoration: BoxDecoration(
                                                  color: BACKGROUND_COLOR_LOADING,
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "$BASE_IMAGE_URL${e.image}"),
                                                    colorFilter: ColorFilter.mode(
                                                        Colors.grey
                                                            .withOpacity(1),
                                                        BlendMode.modulate),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  verticalDirection:
                                                      VerticalDirection.down,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      "${e.subTitle}",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              HEADING_FONT_SIZE,
                                                          color: TEXT_COLOR_WHITE,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${e.title}",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              BIG_HEADING_FONT_SIZE,
                                                          color: TEXT_COLOR_WHITE,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () {

                                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const ShoppingScreen()));

                                                      },
                                                      child: const Text(
                                                        "Shop",
                                                        style: TextStyle(
                                                          fontSize:
                                                              HEADING_FONT_SIZE,
                                                          color: TEXT_COLOR_WHITE,
                                                        ),
                                                      ),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                            width: 1.0,
                                                            color:
                                                                TEXT_COLOR_WHITE),
                                                      ),
                                                    )
                                                  ],
                                                )))
                                    .toList(),

                                //Slider Container properties
                                options: CarouselOptions(
                                  height: 280.0,
                                  initialPage: 0,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 500),
                                  viewportFraction: 1,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                ),
                              ),

                              //---------TOP Category-------------
                              Container(
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  "TOP CATEGORY",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 20.0,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.28 /
                                          MediaQuery.of(context).size.height *
                                          6,
                                    ),
                                    itemCount: subCategoryList!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=> ShoppingScreen(title:subCategoryList[index].title.toString() ,)));
                                        },
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Card(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10))),
                                                    elevation: 0,
                                                    child: Image.network(
                                                      "$BASE_IMAGE_URL${subCategoryList[index].image}",
                                                      fit: BoxFit.cover,
                                                    ))),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                  "${subCategoryList[index].title}"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )),

                              //-------Banners--------
                              Container(
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  "EXCLUSIVE FOR YOU",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              offerList!.isNotEmpty
                                  ? GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShoppingScreen()));
                                },
                                child: Container(
                                        height: 140,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(
                                            "$BASE_IMAGE_URL${offerList[0].image}",
                                          ),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey.withOpacity(1),
                                              BlendMode.modulate),
                                        )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          textBaseline: TextBaseline.alphabetic,
                                          textDirection: TextDirection.ltr,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${offerList[0].subTitle}",
                                              style: const TextStyle(
                                                  fontSize: HEADING_FONT_SIZE,
                                                  color: TEXT_COLOR_WHITE,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${offerList[0].title}",
                                              style: const TextStyle(
                                                  fontSize: BIG_HEADING_FONT_SIZE,
                                                  color: TEXT_COLOR_WHITE,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  )
                                  : Container(),

                              offerList.length >= 3
                                  ? SizedBox(
                                      height: 160,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShoppingScreen()));
                                            },
                                            child: Container(
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.49,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  "$BASE_IMAGE_URL${offerList[1].image}",
                                                ),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.grey.withOpacity(1),
                                                    BlendMode.modulate),
                                              )),
                                              child: Center(
                                                child: Text(
                                                  "${offerList[1].title}",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: TEXT_COLOR_WHITE,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> ShoppingScreen()));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.49,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  "$BASE_IMAGE_URL${offerList[2].image}",
                                                ),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.grey.withOpacity(1),
                                                    BlendMode.modulate),
                                              )),
                                              child: Center(
                                                child: Text(
                                                  "${offerList[2].title}",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: TEXT_COLOR_WHITE,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),

                              //-------Best Sellers----------
                              Container(
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: const Text(
                                  "BEST SELLERS",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: bestSellerList!.length,
                                    itemBuilder: (context, index) {
                                      var temp =
                                          bestSellerList[index].discount! / 100;
                                      var discounted = (bestSellerList[index]
                                              .salePrice! -
                                          (bestSellerList[index].salePrice! *
                                              temp)).floor();
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SingleProduct(id: bestSellerList[index].id!.toInt())));
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              width: 150,
                                              child: Card(
                                                elevation: 0,
                                                child: Image.network(
                                                  "$BASE_IMAGE_URL${bestSellerList[index].product!.image}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Rs $discounted",
                                              style: const TextStyle(
                                                  fontSize: HEADING_FONT_SIZE,
                                                  fontWeight: FontWeight.bold,
                                                  color: HEADING_COLOR),
                                            ),
                                            Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "Rs ${bestSellerList[index].salePrice}",
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey,
                                                    fontSize: TEXT_FONT_SIZE),
                                              ),
                                              TextSpan(
                                                text:
                                                    "  (-${bestSellerList[index].discount})",
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: TEXT_FONT_SIZE),
                                              ),
                                            ])),
                                          ],
                                        ),
                                      );
                                    }),
                              ),

                              Container(
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  "TOP BRANDS",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.28 /
                                          MediaQuery.of(context).size.height *
                                          5,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 20.0,
                                    ),
                                    itemCount: brandList!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=> ShoppingScreen(title:brandList[index].title.toString() ,)));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: Card(
                                                      color:
                                                          BACKGROUND_COLOR_LOADING,
                                                      elevation: 0,
                                                      child: Image.network(
                                                        "$BASE_IMAGE_URL${brandList[index].image}",
                                                        fit: BoxFit.cover,
                                                      ))),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${brandList[index].title}",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: TEXT_COLOR),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              const SizedBox(
                                height: 30,
                              ),

                              //-------Top Trending-----------
                              SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 1,
                                child: Image.asset(
                                  "images/toptrending.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height *
                                              0.8),
                                      mainAxisSpacing: 20.0,
                                    ),
                                    itemCount: productList!.length,
                                    itemBuilder: (context, index) {
                                      var product = productList[index];
                                      var temp = product.discount! / 100;
                                      var discounted = product.salePrice! -
                                          (product.salePrice! * temp);
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SingleProduct(id: product.id!.toInt())));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: Card(
                                                      elevation: 0,
                                                      child: Image.network(
                                                        "$BASE_IMAGE_URL${product.product!.image}",
                                                        fit: BoxFit.cover,
                                                      ))),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                    text:
                                                        "${product.product!.title}",
                                                    style: const TextStyle(
                                                        fontSize:
                                                            HEADING_FONT_SIZE,
                                                        color: HEADING_COLOR),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Rs $discounted",
                                                style: const TextStyle(
                                                    fontSize: HEADING_FONT_SIZE,
                                                    fontWeight: FontWeight.bold,
                                                    color: HEADING_COLOR),
                                              ),
                                              Text.rich(
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                  text: "Rs ${product.salePrice}",
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontSize: TEXT_FONT_SIZE),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "  (-${product.discount})",
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: TEXT_FONT_SIZE),
                                                ),
                                              ])),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              //------Load more button----------
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () async{
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShoppingScreen()));
                                  },
                                  child:Ink(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*0.6,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(colors: [
                                            Color.fromRGBO(244, 84, 70, 1),
                                            Color.fromRGBO(225, 42, 90, 1)
                                          ]),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: const Center(
                                        child: Text("Load More",style: TextStyle(fontSize: HEADING_FONT_SIZE),),
                                      )
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const FooterExpansion(),
                              const SizedBox(height: 50,)
                            ]);
                          }
                        },
                      ),

                    ])))),
          ],
        ));
  }
}
