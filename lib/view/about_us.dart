import 'package:flutter/material.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                  Center(child: Text("About Us", style: TextStyle(
                      fontSize: BIG_HEADING_FONT_SIZE,
                      fontWeight: FontWeight.bold,
                      color: HEADING_COLOR),)),
                  SizedBox(height: 20,),
                  Text("OUR STORY", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "Started in 2021, a dream turned to reality through a Facebook Page that won the hearts of many fashionistas in Pakistan who had the continuous quench to grow themselves to become trendsetters. From this point in time, we have hustled hard to align our mission with our fans by bringing the latest western fashion to Pakistan. After successfully bridging the miles between different parts of the world to build an efficient supply chain network, we launched www.nexgen-shop.com in 2022. Each day, we not only deliver products to our valued customers, but in the bigger picture, we deliver excellent customer experience, support and trust at doorsteps. This year, we plan on delivering greater value to each customer and promise to give you a future full of online shopping convenience, great deals and discounts.",
                    style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("WHO ARE WE?", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "We are a dedicated team of professionals working hard to provide high-end western fashion from every part of the world to your doorstep in only 18-25 Days. From runway inspired clothing and handbags to collector’s dream list of watches, shoes and fragrances, www.nexgen-shop.com has everything to satisfy your thirst for fashion."
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("HOW TO PLACE AN ORDER WITH US?", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "Visit nexgen-shop.com. Explore our categories and choose your favorite product. Add it to your cart. Fill the details at checkout and place your order. Sit back and relax. You’ll receive your order within 18-25 days."
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("REASONS TO LOVE US", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "Convenient shopping Shop from 500+ brands Excellent Customer Support"
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("WHAT WE OFFER", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "Women Fashion Handbags, Shoes, Clothing, Accessories, Cosmetics Men Fashion Clothing, Shoes, Accessories, Fragrances Kids Fashion Clothing, Shoes, Accessories"
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
