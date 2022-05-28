import 'package:flutter/material.dart';
import 'package:quantum_genius/view/about_us.dart';
import 'package:quantum_genius/view/faq_screen.dart';
import 'package:quantum_genius/view/privacy_policy.dart';
import 'package:quantum_genius/view/refund_policy.dart';

import '../utils/colors.dart';
class FooterExpansion extends StatelessWidget {
  const FooterExpansion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: Colors.black,
      iconColor: Colors.black,
      title:const Text(
        "More About NexGen Shop",
        style: TextStyle(fontSize: 14, color:HEADING_COLOR),
      ),
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const AboutUs()));
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.assignment_return,
                          size: 30,
                        ),
                      ),
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.contact_support_outlined,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const FAQScreen()));

          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.question_mark_rounded,
                          size: 30,
                        ),
                      ),
                      Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const RefundPolicy()));

          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.keyboard_return_rounded,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Refunds Policy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const PrivacyPolicy()));

          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.policy_outlined,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
