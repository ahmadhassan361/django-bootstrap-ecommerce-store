import 'package:flutter/material.dart';
import 'package:quantum_genius/models/user_models.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:quantum_genius/utils/shared_pref_funcs.dart';
import 'package:quantum_genius/view/faq_screen.dart';
import 'package:quantum_genius/view/login.dart';
import 'dart:math' as math;
import 'package:quantum_genius/view/main_screen.dart';
import 'package:quantum_genius/view/my_orders.dart';
import 'package:quantum_genius/view/mydetail.dart';
import 'package:quantum_genius/view/privacy_policy.dart';
import 'package:quantum_genius/view/refund_policy.dart';

import 'about_us.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin<Profile>{
  @override
  bool get wantKeepAlive => true;
  bool login = false;
  AuthModel? authModel;

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            login
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                children:  [
                                  CircleAvatar(
                                    minRadius: 50,
                                    backgroundColor: HEADING_COLOR,
                                    child: Center(
                                      child: Text(
                                        authModel?.customer?.fullname?.substring(0,1).toUpperCase() ?? "",
                                        style:const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    authModel?.customer?.fullname?.toUpperCase() ?? "",
                                    style: const TextStyle(
                                        fontSize: HEADING_FONT_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyOrders()));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(244, 84, 70, 1),
                                  Color.fromRGBO(225, 42, 90, 1)
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Icon(
                                      Icons.shopping_cart_checkout_outlined,
                                      size: 30,
                                      color: HEADING_COLOR,
                                    ),
                                  ),
                                  Text(
                                    'My Orders',
                                    style: TextStyle(
                                      fontSize: HEADING_FONT_SIZE,
                                      fontWeight: FontWeight.bold,
                                      color: HEADING_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyDetail()));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Card(
                            elevation: 4,
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  'My Details',
                                  style: TextStyle(
                                    fontSize: HEADING_FONT_SIZE,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: BACKGROUND_COLOR_LOADING,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const AboutUs()));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  elevation: 4,
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
                  elevation: 4,
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
                  elevation: 4,
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
                  elevation: 4,
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
                  elevation: 4,
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
            login?GestureDetector(
              onTap: () async {
                final result = await logout().then((value) => {
                      if (value)
                        {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainScreen()),
                              (route) => false)
                        }
                    });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  color: HEADING_COLOR,
                  elevation: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Transform.rotate(
                              angle: 180 * math.pi / 180,
                              child: const Icon(
                                Icons.logout_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            'Sign out',
                            style: TextStyle(
                                fontSize: HEADING_FONT_SIZE,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ):const SizedBox(),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
