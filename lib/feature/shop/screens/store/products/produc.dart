import 'dart:convert';
import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/feature/shop/screens/home/home.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, this.id = '0'});
  final String id;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List booksSearchList = [];
  String bookName = '';

  

  Future<http.Response> _getBooksBySearch(String bookName) async {
    final http.Response response = await Network().postData({
      "name": bookName,
      "O": '0',
      "S": '16'
    }, '/getBookByName.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        booksSearchList = res['books'];
      });
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getBooksBySearch(bookName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        id: widget.id,
        showDefaultLeading: true,
        actions: [
          CustomCartWidget(
            id: widget.id,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              const CustomHeadingWidget(
                title: 'All Products',
                btnText: '',
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              SearchWidget(onChanged: (val) {
                _getBooksBySearch(val);
              }, onPressedFn: () {
              }),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              HomeGridViewWidget(booksList: booksSearchList , id: widget.id,),
            ],
          ),
        ),
      ),
    );
  }
}
