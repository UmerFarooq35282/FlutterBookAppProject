import 'dart:convert';

import 'package:book_store/feature/authentication/screens.onboarding/login/login.dart';
import 'package:book_store/feature/shop/screens/addToCart/addto_cart.dart';
import 'package:book_store/feature/shop/screens/wishlist/wishlist.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../../feature/shop/controller/NetworkHelper.dart';

class VerticalCardWidget extends StatefulWidget {
  const VerticalCardWidget({
    super.key,
    required this.book,
    required this.onTap,
    required this.showheartIconFn,  this.id = '0',
  });
  final Map<String, dynamic> book;
  final VoidCallback onTap;
  final VoidCallback showheartIconFn;
  final String id;
  @override
  State<VerticalCardWidget> createState() => _VericalCardState();
}

class _VericalCardState extends State<VerticalCardWidget> {
  Future<http.Response> _addToCart() async {
    final http.Response response = await Network().postData({
      "bkId": "${widget.book['BookID']}",
      "cusId": widget.id,
      "price": "${widget.book['Price']}",
      "quantity": '1',
    }, '/insert_order_items.php');

    print('response ---- ${jsonDecode(response.body)}');

    return response;
  }

  Future<http.Response> _addToWishlist() async {
    final http.Response response = await Network().postData({
      "bkId": "${widget.book['BookID']}",
      "cusId": widget.id,
    }, '/insert_wishlist_items.php');

    print('response ---- ${jsonDecode(response.body)}');

    return response;
  }

  void _showConfirmationDailog(){
    
    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Information' , style: TextStyle(
          color: Colors.black , fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("Please Login Fisrt for this feature" , style: TextStyle(
          color: Colors.black , fontSize: 14, fontWeight: FontWeight.w600
        ),),
        actions:   [
          Row(
            children: [
              SizedBox(width: 120, child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancle')),),
          const SizedBox(width: TSizes.spaceBtwInputFields,),
          SizedBox(width: 120, child: ElevatedButton(onPressed: (){
            final route = MaterialPageRoute(builder: (context) => const LoginScreen());
            Navigator.push(context, route);
          }, child: const Text('Okay')),),
            ],
          )
        ],
      );
    },);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child:Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                // color: TColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2)),
                  child: Image(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                          'assets/images/Products/${widget.book['images']}')),
                ),
                const SizedBox(
                  height: TSizes.spcBtwItems / 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "${widget.book['Title']}",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 00,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.book['Price']}',
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.book['name'],
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: widget.id != '0' ? () {
                                  _addToWishlist();
                                  final route = MaterialPageRoute(builder: (context) =>  WishListScreen(userId: widget.id,));
                                  Navigator.push(context, route);
                                } : (){
                                  _showConfirmationDailog();
                                },
                                icon: const Icon(
                                  Iconsax.heart,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                  onPressed: widget.id != '0' ? () {
                                    _addToCart();
                                    final route = MaterialPageRoute(
                                        builder: (context) =>
                                          CartScreen(id: widget.id,));
                                    Navigator.push(context, route);
                                  } : (){
                                    _showConfirmationDailog();
                                  },
                                  icon: const Icon(Iconsax.add_square)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        
    );
  }
}
