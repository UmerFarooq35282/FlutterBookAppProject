import 'dart:convert';

import 'package:book_store/bottom_navigation.dart';
import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
// import 'package:book_store/common/widgets/products/vertical_cart.dart';
import 'package:book_store/feature/shop/screens/home/home.dart';
// import 'package:book_store/feature/shop/screens/store/store.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../controller/NetworkHelper.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key, this.userId = 
  ''});

  final String userId;
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List wishlistItems = [];


  Future<http.Response> _getWishlistItems() async {
    final http.Response response =
        await Network().postData(
          {
            "id": widget.userId
          }, 
          '/getFavItemByCusId.php'
          );

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        wishlistItems = res['wishlist_items'];
      });
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWishlistItems();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:   CustomAppBar(
        id: widget.userId,
        leadingIcon: const Icon(Iconsax.arrow_circle_left),
        leadingOnPressed: (){
          final route = MaterialPageRoute(builder: (context) => ProductTabPage(id: widget.userId != '' ? widget.userId : '0' ,title: wishlistItems.isNotEmpty ? wishlistItems[0]['Name'] : "Guest",));
          Navigator.push(context, route);
        },
        actions:  [
          CustomCartWidget(id: widget.userId,)
        ],
      ),
      body: wishlistItems.isNotEmpty ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
          child: Column(
            children: [
               CustomHeadingWidget(title: "${wishlistItems[0]['Name']} 's Wishlist ", btnText: '',),
              const SizedBox(height: TSizes.spaceBtwSections,),
              HomeGridViewWidget(booksList: wishlistItems , id: widget.userId,)
            ],
          ),
        ),
      ) : Center(
        child: Text(
          "WishList Is Empty " , style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}