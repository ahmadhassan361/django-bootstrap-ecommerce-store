import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../models/single_product_models.dart';
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key,required this.reviewList}) : super(key: key);
  final List<Reviews> reviewList;
  @override
  State<ReviewScreen> createState() => _ReviewScreenState(reviewList);
}

class _ReviewScreenState extends State<ReviewScreen> {
  _ReviewScreenState(this.reviewList);
   List<Reviews> reviewList;

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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Center(child: Text(getRatings(reviewList).toString(),style: const TextStyle(fontSize: 22,color: HEADING_COLOR,fontWeight: FontWeight.bold),)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RatingBar.builder(
                ignoreGestures: true,
                initialRating: getRatings(reviewList),
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
                "Based on ${reviewList.length} review",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 14,),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: reviewList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 40,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: HEADING_COLOR
                                ),
                                child: Center(child: Text(reviewList[index].customer?.fullname?.toUpperCase().substring(0,1) ?? "",style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: HEADING_FONT_SIZE
                                ),),),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${reviewList[index].customer?.fullname} ",style: const TextStyle(fontSize: HEADING_FONT_SIZE,color: HEADING_COLOR,fontWeight: FontWeight.bold),),
                                  RatingBar.builder(
                                    initialRating: reviewList[index].rating?.toDouble() ?? 0.0,
                                    minRating: 1,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    itemPadding:
                                    const EdgeInsets.only(right: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {

                                    },
                                  ),
                                   SizedBox(
                                       width: MediaQuery.of(context).size.width*0.8,
                                       child: Text(reviewList[index].review ?? "",overflow: TextOverflow.ellipsis,maxLines: 6,))
                                ],
                              )
                            ],
                          ),
                          const Divider(thickness: 1,)
                        ],
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }
  getRatings(List<Reviews> list){
    if(list.isEmpty){
      return 5.0;
    }
    var rat = 0;
    for(int i=0;i<list.length;i++){
      rat += list[i].rating!;
    }
    var result = rat/list.length;
    return (result>0?result:0.0);
  }

}
