// import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/feature/shop/screens/profile/profile.dart';
import 'package:book_store/feature/shop/screens/store/products/produc.dart';
// import 'package:book_store/feature/shop/screens/store/store.dart';
import 'package:book_store/feature/shop/screens/wishlist/wishlist.dart';
import '/feature/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';

class BottonMenuNavigation extends StatelessWidget {
  const BottonMenuNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (value) =>
                controller.selectedIndex.value = value,
            destinations: const <Widget>[
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.book), label: 'Books'),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Authors'),
            ]),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    // const HomeScreen(),
    const ProductsScreen(),
    const WishListScreen(),
    const ProfileScreen()
  ];
}

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});
  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {


  List<Widget> screens = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      // const HomeScreen(),
      const ProductsScreen(),
      const WishListScreen(),
      const ProfileScreen()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          NavigationBar(
            onDestinationSelected: (value) => setState(() {
              index = value;
            }),
            selectedIndex: index, 
            destinations: const <Widget>[
        NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
        NavigationDestination(icon: Icon(Iconsax.book), label: 'Books'),
        NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
        NavigationDestination(icon: Icon(Iconsax.user), label: 'Authors'),
      ]),
      body: screens[index],
    );
  }
}


class ProductTabPage extends StatefulWidget {
  const ProductTabPage({super.key,  this.title = '',  this.id = '0', this.role = 'user'});

  final String title;
  final String id;
  final String role;

  @override
  State<ProductTabPage> createState() => _ProductTabPageState();
}

class _ProductTabPageState extends State<ProductTabPage> {
 

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        body:  TabBarView(children: [
          HomeScreen(title: widget.title, id: widget.id, role: widget.role,),
          ProductsScreen(id: widget.id,),
          WishListScreen(userId: widget.id,),
          // const AuthorsPage(),
        // AddtoCartPage(title: "Main Screen"),
         
        ]),
        bottomNavigationBar: SafeArea(
            child: TabBar(
              labelColor: Colors.blueAccent,
              unselectedLabelColor: isDark ? Colors.white : Colors.black,
              tabs: const [
          Tab(icon: Icon(Iconsax.home), text: "Home"),
          Tab(icon: Icon(Iconsax.book), text: "Books"),
          Tab(icon: Icon(Iconsax.heart), text: "Wishlist"),
          // Tab(icon: Icon(Iconsax.user), text: "Authors"),
        ])),
      ),
    );
  }
}
