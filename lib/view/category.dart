import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quantum_genius/models/categorymodel.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:quantum_genius/view/shopping_screen.dart';
class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> with AutomaticKeepAliveClientMixin<Category> {
  @override
  bool get wantKeepAlive => true;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  List<MainCategories>? mainCategories;
  
  Future<bool> getCategories() async{
    var url = Uri.parse("$BASE_URL$CATEGORIES_END_POINT");
    final response =await http.get(url);
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      print(result);
      List<MainCategories> mainList=[];
      for(int i=0;i<result.length;i++){
        mainList.add(MainCategories.fromJson(result[i]));
      }
      mainCategories = mainList;
      setState((){

      });
      return true;
    }else{
      return false;
    }
  }
  final List<Color> circleColors = [
    const Color.fromRGBO(201, 225, 248, 1),
    const Color.fromRGBO(237, 215, 207, 1),
    const Color.fromRGBO(248, 231, 201, 1),
    const Color.fromRGBO(242, 181, 189, 1),
    const Color.fromRGBO(214, 187, 180, 1),
  ];

  Color randomGenerator() {
    return circleColors[Random().nextInt(4)];
  }
  
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async{
          var result = await getCategories();
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
          },
        child: SingleChildScrollView(
          child: Column(
            children:mainCategories !=null? mainCategories!.map((e) => Padding(
              padding: const EdgeInsets.only(top: 3),
              child: ExpansionTile(

                textColor: Colors.black,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children:  [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child:  Text(e.cat!.title.toString(),
                          style: const TextStyle(color: HEADING_COLOR,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage("$BASE_IMAGE_URL${e.cat!.image}"),
                              fit: BoxFit.cover
                          )
                        ),
                          height: 80,
                          width: 80,
                           ),

                    ],
                  ),
                ),
                collapsedBackgroundColor: randomGenerator(),
                backgroundColor:   Colors.white,
                iconColor: Colors.black,
                children: e.subList!.map((s) => Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        color: const Color.fromARGB(150, 198, 197, 195),
                        height: 50,
                        width: MediaQuery.of(context).size.width*1,
                        child:  Center(
                          child: Text(
                            s.sub!.title.toString(),
                            style: const TextStyle(
                                color: HEADING_COLOR,
                                fontSize: HEADING_FONT_SIZE,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: s.subsublist!.map((ss) => Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ShoppingScreen(title:ss.title.toString())));
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(ss.title.toString(),style: const TextStyle(fontSize: 14,color: HEADING_COLOR,fontWeight: FontWeight.bold),),
                                ),
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(thickness: 1.5,
                              ),
                            ),
                          ],
                        )).toList(),
                      )





                    ],
                  ),
                )).toList(),
              ),
            )).toList():[]
          ),
        ),
      ),
    );
  }
}
