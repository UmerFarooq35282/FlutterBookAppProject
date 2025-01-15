// import 'dart:convert';

import 'dart:convert';

import 'package:book_store/feature/shop/screens/addToCart/addto_cart.dart';
import 'package:book_store/utils/constants/colors.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../../feature/shop/controller/NetworkHelper.dart';

// class HorizontalCardWidget extends StatelessWidget {
//   const HorizontalCardWidget({
//     super.key, this.showQuantityGrid = false, 
//      this.image = '', 
//      this.bookName = '', 
//      this.bookDesc = '', 
//      this.quantity = '', 
//      this.price = '', 
//      this.totalPrice = '', required this.list,
//   });
//   final bool showQuantityGrid;
//   final String image;
//   final String bookName;
//   final String bookDesc;
//   final String quantity;
//   final String price;
//   final String totalPrice;
//   final Map<String , dynamic> list;
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(5),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: isDark ? TColors.darkerGrey : Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           boxShadow: const [
//              BoxShadow(
//               color: Color.fromARGB(255, 149, 149, 149),
//               offset: Offset(2, 3)
//             )
//           ]
//           ),
//       child: Row(
//         children: [
//           Container(
//             height: 140,
//             width: 100,
//             decoration: const BoxDecoration(
//                 // color: Color.fromARGB(255, 184, 184, 184),
//                 ),
//             child:  Center(
//               child: Image(
//                 image:  AssetImage('assets/images/Products/${list['ImageURL']}'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 15,),
//           SizedBox(
//             width: 320,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "${list['Title']}",
//                   style: TextStyle(
//                     color: isDark ?Colors.white : Colors.black
//                   ),
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields,),
//                 Text(
//                   "${list['description']}",
//                   maxLines: 2,
//                   style: TextStyle(
//                     color: isDark ?Colors.white : Colors.black
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields,),
                
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("${list['Quantity']}" , style: TextStyle(
//                     color: isDark ?Colors.white : Colors.black
//                   ),),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               print(isDark);
//                             }, icon: const Icon(Icons.add)),
//                         IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.remove)),
//                       ],
//                     )
//                   ],
//                 ),
//                   Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("${list['Price']}" , style: TextStyle(
//                     color: isDark ?Colors.white : Colors.black
//                   ),),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total : ${list['TotalPrice']}" , style: TextStyle(
//                     color: isDark ?Colors.white : Colors.black
//                   ),)
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HorizontalCardWidget extends StatefulWidget {
  const HorizontalCardWidget({super.key, required this.list, this.id = '0', this.showDelete = false});
  final Map<String , dynamic> list;
  final String id;
  final bool showDelete;
  @override
  State<HorizontalCardWidget> createState() => _HorizontalCardWidgetState();
}

class _HorizontalCardWidgetState extends State<HorizontalCardWidget> {

  List booksSearchList = [];

   Future<http.Response> _addToCart() async {
    final http.Response response = await Network().postData({
      "bkId": "${widget.list['BookID']}",
      "cusId": widget.id,
      "price": "${widget.list['Price']}",
      "quantity": '1',
    }, '/insert_order_items.php');

    // print('response ---- ${jsonDecode(response.body)}');

    return response;
  }

  Future<http.Response> _deleteToCart() async {
    final http.Response response = await Network().postData({
      "id": "${widget.list['orderId']}"
    }, '/remove_order_items.php');

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
        content: const Text("Do you Really Want to delete Cart Item" , style: TextStyle(
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
            _deleteToCart();
            final route = MaterialPageRoute(builder: (context) =>  CartScreen(id: widget.id,));
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isDark ? TColors.darkerGrey : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
             BoxShadow(
              color: Color.fromARGB(255, 149, 149, 149),
              offset: Offset(2, 3)
            )
          ]
          ),
      child: Row(
        children: [
          Container(
            height: 140,
            width: 100,
            decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 184, 184, 184),
                ),
            child:  Center(
              child: Image(
                image:  AssetImage('assets/images/Products/${widget.list['ImageURL']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15,),
          SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.list['Title']}",
                  style: TextStyle(
                    color: isDark ?Colors.white : Colors.black
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                Text(
                  "${widget.list['description']}",
                  maxLines: 2,
                  style: TextStyle(
                    color: isDark ?Colors.white : Colors.black
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.list['Quantity']}" , style: TextStyle(
                    color: isDark ?Colors.white : Colors.black
                  ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.showDelete ?
                        IconButton(
                            onPressed: () {
                              _showConfirmationDailog();
                            }, icon: const Icon(Iconsax.trash)) : const SizedBox(),
                        IconButton(
                            onPressed: () {
                              _addToCart();
                              final route = MaterialPageRoute(builder: (context) =>  CartScreen(id: widget.id,));
                              Navigator.push(context , route);
                              print(widget.list);
                            }, icon: const Icon(Icons.add)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.remove)),
                      ],
                    )
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.list['Price']}" , style: TextStyle(
                    color: isDark ?Colors.white : Colors.black
                  ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total : ${widget.list['TotalPrice']}" , style: TextStyle(
                    color: isDark ?Colors.white : Colors.black
                  ),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}