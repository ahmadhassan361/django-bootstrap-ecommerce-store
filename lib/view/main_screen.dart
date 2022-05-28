import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quantum_genius/view/cart.dart';
import 'package:quantum_genius/view/category.dart';
import 'package:quantum_genius/view/home_screen.dart';
import 'package:quantum_genius/view/profile.dart';
import 'package:quantum_genius/view/shopping_screen.dart';
import 'package:quantum_genius/view/wishlist.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var _selectedPageIndex = 0;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      //The individual tabs.
      const HomeScreen(),
      const Category(),
      const Cart(),
      const Profile()
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  final iconList = <IconData>[
    Icons.home,
    Icons.dashboard_rounded,
    Icons.shopping_bag,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
             InkWell(
               onTap: (){
                     _onItemTapped(0);
               },
               child: SizedBox(
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
             ),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search_rounded,color: Colors.black,),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const ShoppingScreen()));
            },),
            // IconButton(icon: const Icon(Icons.favorite_border_outlined,color: Colors.black,),onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (_)=>const WishList()));
            // },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const ShoppingScreen()));

      },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color.fromRGBO(244, 84, 70, 1), Color.fromRGBO(225, 42, 90, 1)])),
          child:  const Icon(Icons.whatshot_rounded,color: Colors.white, ),
        ),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedPageIndex,
        gapLocation: GapLocation.center,
        activeColor: Colors.black,
        inactiveColor: Colors.black54,
        notchSmoothness: NotchSmoothness.softEdge,
        splashColor: Colors.red,
        splashSpeedInMilliseconds: 300,
        onTap: (index) => _onItemTapped(index),
        //other params
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
