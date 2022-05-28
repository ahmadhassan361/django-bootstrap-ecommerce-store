import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/models/stock_model.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/functions.dart';
import 'package:quantum_genius/view/single_product_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../models/shopping_list_model.dart';
import '../utils/endpoints.dart';
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key,this.title = ""}) : super(key: key);
  final String title;
  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState(title);
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  _ShoppingScreenState(this.title);

   String title;
  var searchController = TextEditingController();

  String? nextPage;

  Future<bool> getProductList({bool isRefresh = false,String keyword = "",orderBy = "",bool isSearch= false}) async{
    if(title.isNotEmpty && !isSearch){
      setState((){
        searchController.text = title;
        keyword = title;
      });

    }
    if(orderBy.isNotEmpty){
      if(orderBy=='A-Z'){
        orderBy = 'product__title';
        print(orderBy);
      }else if(orderBy=='Z-A'){
        orderBy = '-product__title';
        print(orderBy);
      }else if(orderBy=='L - H Price'){
        orderBy = 'sale_price';
        print(orderBy);
      }else if(orderBy=='H - L Price'){
        orderBy = '-sale_price';
        print(orderBy);
      }
    }

    String url ="$BASE_URL$PRODUCT_LIST_END_POINT?search=$keyword&orderby=$orderBy";
    if (isRefresh && !isSearch) {

      url = "$BASE_URL$PRODUCT_LIST_END_POINT?search=${searchController.text}&orderby=$orderBy";
    }else if(isSearch){
      url = "$BASE_URL$PRODUCT_LIST_END_POINT?search=$keyword&orderby=$orderBy";
    }
    else {
      if (nextPage == null) {
        refreshController.loadNoData();
        return false;
      }
      else{
        url = nextPage!;
      }
    }


    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      print(json);
      final res = ShoppingListModel.fromJson(json);
      var stockList1 = res.results;
      if (isRefresh) {
        stockList = stockList1!;
        // stockList.shuffle();
      }else{
        stockList1!.shuffle();
        stockList.addAll(stockList1);
      }
      if (res.next != null){
        nextPage = res.next!;
      }else{
        nextPage = null;
      }

      setState((){
        if(keyword.isNotEmpty && isRefresh & !isSearch){
          searchController.text = keyword;
        }
      });
      return true;
    }
    else {
      return false;
    }
  }
  String? selectedValue;
  List<StockModel> stockList = [];

  final RefreshController refreshController = RefreshController(initialRefresh: true);
  List<String> items_sort = [
    'A-Z',
    'Z-A',
    'L - H Price',
    'H - L Price',
  ];
  List<String> items_filter = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
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
          controller:refreshController,
          enablePullUp: true,
          onRefresh: ()async{
            final result = await getProductList(isRefresh: true);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async{
            final result = await getProductList();
            if (result) {
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }

          },
          child:SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    child: Theme(
                      data: Theme.of(context).copyWith(primaryColor: HEADING_COLOR),
                      child: TextField(

                        controller: searchController,
                        textInputAction: TextInputAction.go,
                        textAlign: TextAlign.start,
                        autofocus: false,
                        onSubmitted: (text)async{
                          hideKeyboard();
                          final result = await getProductList(isRefresh: true,keyword: text);
                          if (result) {
                            refreshController.refreshCompleted();
                          } else {
                            refreshController.refreshFailed();
                          }
                        },
                        onChanged: (val){
                          if(val.isEmpty){
                            setState((){
                              searchController.text = "";
                              title = "";
                            });
                          }
                        },
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.zero,
                            alignLabelWithHint: true,
                            prefixIcon: const Icon(Icons.search,color: HEADING_COLOR,),
                            suffixIcon: searchController.text.isNotEmpty?IconButton(
                              icon: const Icon(Icons.clear,color: HEADING_COLOR,),
                              onPressed: () async{

                                setState((){
                                  searchController.text = "";
                                  title = "";
                                });
                                final result = await getProductList(isRefresh: true);
                                if (result) {
                                  refreshController.refreshCompleted();
                                } else {
                                  refreshController.refreshFailed();
                                }
                              },
                            ):null,

                            hintText: 'Search...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.black
                                )
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(

                          child: DropdownButton2(
                            hint: Row(
                              children: const [
                                Icon(Icons.sort,color: HEADING_COLOR),
                                SizedBox(width: 10,),
                                Text(
                                  'Sort',
                                  style: TextStyle(

                                    fontSize: 14,
                                    color: HEADING_COLOR,
                                  ),
                                ),

                              ],
                            ),
                            items: items_sort
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value)async {
                              selectedValue = value as String;
                              final result = await getProductList(isRefresh: true,orderBy:selectedValue);
                              if (result) {
                                refreshController.refreshCompleted();
                              } else {
                                refreshController.refreshFailed();
                              }
                              setState(() {


                              });



                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            buttonElevation: 10,
                            buttonPadding: const EdgeInsets.all(10),

                          ),
                        ),
                        const Spacer(),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        const Spacer(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Row(
                              children: const [
                                Icon(Icons.dashboard_customize,color: HEADING_COLOR,),
                                SizedBox(width: 10,),
                                Text(
                                  'Filter',
                                  style: TextStyle(

                                    fontSize: 14,
                                    color: HEADING_COLOR,
                                  ),
                                ),

                              ],
                            ),
                            items: items_filter
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            // value: selectedValue,
                            // onChanged: (value) {
                            //   setState(() {
                            //     selectedValue = value as String;
                            //   });
                            // },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ],),
                  ),
                ),
                Container(
                  color: BACKGROUND_COLOR,
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridView.builder(
                        physics:
                        const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: MediaQuery.of(context)
                              .size
                              .width *
                              0.28 /
                              MediaQuery.of(context).size.height *
                              4,
                        ),
                        itemCount: stockList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>SingleProduct(id: stockList[index].id!.toInt())));
                            },
                            child: Card(
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: Image.network(
                                          "${stockList[index].product!.image}",
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )),
                                  Padding(
                                      padding:const EdgeInsets.only(left: 5.0,right: 0,top: 5),
                                      child: Row(
                                        children:  [
                                          Text(
                                            stockList[index].product!.brand!.title.toString().toUpperCase(),style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          IconButton(onPressed: (){

                                          }, icon: const Icon(Icons.favorite_border_outlined,color: Colors.grey,))
                                        ],
                                      )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5.0,right: 5,top: 2,bottom: 5),
                                      child: Text(
                                        stockList[index].product!.title.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(color: HEADING_COLOR,fontWeight: FontWeight.bold),)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5,bottom: 15),
                                    child: Text(
                                      "Rs ${stockList[index].salePrice}",style: const TextStyle(color: HEADING_COLOR,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                )
              ],
            ),
          ),),
    );
  }

}
