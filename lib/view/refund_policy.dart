import 'package:flutter/material.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({Key? key}) : super(key: key);

  @override
  State<RefundPolicy> createState() => _RefundPolicyState();
}

class _RefundPolicyState extends State<RefundPolicy> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(child: Text("Refund Policy", style: TextStyle(
                      fontSize: BIG_HEADING_FONT_SIZE,
                      fontWeight: FontWeight.bold,
                      color: HEADING_COLOR),)),
                  SizedBox(height: 20,),
                  Text("1- If your product is damaged, defective, or incomplete at the time of delivery, please file a return request within 12 hours of delivery.", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "2- Please contact Customer Service at nexgenshopofficial@gmail.com, indicating the item(s) you would like to return and the reason."
                    , style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE, color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("3- Attach packaging pictures along with the product pictures from different angles.", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("4- Shipping Damages / Broken Items:NexGenShop takes the best possible measures in providing sustainable packaging but since some of the makeup items are fragile, and can be damaged by the shipping company during the transit, you need to share the proof of damage within 6 hours of receiving those items, and we will not return or exchange such items, but we will provide you a discount coupon equivalent to the damage happened. We will require 7-10 business days to settle these claims.", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("5- Reserved Rights Regarding Returns", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("6- We reserve the right to solely define and limit, refuse, and/or reject returns from customers at any time due to", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("7- An irregular or excessive returns history indicative of 'wardrobing;'", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("8- An irregular or excessive returns history involving worn, altered, laundered, damaged, or missing items; or", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text("9- Potential fraudulent or criminal activity.", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  SizedBox(height: 20,),
                  Text("Return Condition", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "The following items cannot be returned or exchanged: bodysuits, lingerie, jewelry. Returned items must be in unused condition with the original packing. We do not accept returned items that have been worn, damaged, washed, or altered in any way. We do not accept returned items that have been sent back without proper returns requests. NOTE: Refund amount will be deducted in case NexGenShop founds any returned product altered in any way."
                    ,style: TextStyle(color: HEADING_COLOR),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
