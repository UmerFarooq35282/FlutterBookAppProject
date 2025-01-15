import 'dart:convert';
import 'package:book_store/common/widgets/products/horizontal_card.dart';
// import 'package:book_store/feature/shop/screens/store/store.dart';
import 'package:book_store/utils/constants/sizes.dart';
// import 'package:book_store/common/widgets/products/custom_heading.dart';
// import 'package:book_store/feature/shop/screens/store/store.dart';
// import 'package:book_store/feature/shop/screens/store/store.dart';
// import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/NetworkHelper.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key,  this.id = '0',});
  final String id;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List booksSearchList = [];


  Future<http.Response> _getOrdersItem() async {
    final http.Response response = await Network()
        .postData({
          "id": widget.id,        
          }, '/getOrderItemByCusId.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        booksSearchList = res['Orders_items'];
      });
    });
    return response;
  } 

  @override
  void initState() {
    super.initState();
    _getOrdersItem();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar:  AppBar(
            title: Text("Cart Screen" , style: Theme.of(context).textTheme.headlineMedium,),
            actions: [
              booksSearchList.isNotEmpty ?
              ElevatedButton(onPressed: (){}, child: Text('CheckOut'))
              : Text('')
            ],
          ),
          body:booksSearchList.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
            child: SizedBox(
              child: ListView.builder(
                itemCount: booksSearchList.length,
                itemBuilder: (_, index){
                final book = booksSearchList[index];
                return  HorizontalCardWidget(
                  showDelete: true,
                  list: book,
                  id: widget.id,
                );
              }),
            ),
          ) : Center(
            child: Text('Cart is Empty' , style:  Theme.of(context).textTheme.headlineLarge,),
          )
        );
  }
}