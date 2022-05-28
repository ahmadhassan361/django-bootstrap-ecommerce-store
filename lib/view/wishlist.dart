import 'package:flutter/material.dart';

import 'single_product_screen.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Whislist",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height*0.67),
                // mainAxisSpacing: 1,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(elevation: 10,
                  child: Column(
                  children: [
                    Image.asset("images/mens.jpg"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 5),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Rs 2,550",style: TextStyle(fontSize: 13,color: Colors.grey[700]),)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: Colors.green,
                        fixedSize: const Size(180, 30),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>  SingleProduct(id: 6)));
                      },
                      child: Text("ADD TO BAG",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                    ),
                  ],
                  ),
                );
                // return Container(,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: [
                //         Container(
                //             height:200,
                //             child: Image.asset('images/mens.jpg')),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 130),
                //           child: Text("RS 2,550"),
                //         ),
                //
                //         Expanded(
                //           child: ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               onPrimary: Colors.black87,
                //               primary: Colors.green,
                //               fixedSize: Size(150, 50),
                //               shape: RoundedRectangleBorder(),
                //               padding: EdgeInsets.symmetric(horizontal: 16),
                //             ),
                //             onPressed: () {},
                //             child: Text("Add to bag"),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
