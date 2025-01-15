import 'dart:convert';

import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/feature/shop/screens/store/authors/authors.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../controller/NetworkHelper.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key , required this.bookId,  this.id = '0'});
  final String bookId;
  final String id;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  List booksSearchList = [];
  String bookName = '';

  

  Future<http.Response> _getBookDetail() async {
    final http.Response response = await Network().postData({
      "id": widget.bookId
    }, '/getBookById.php');

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
    // TODO: implement initState
    super.initState();
    _getBookDetail();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        showDefaultLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
        child: Column(
          children: [
            CustomHeadingWidget(title: booksSearchList[0]['author_name'], btnText: 'Author detail', btnOnPressed: (){
              final route = MaterialPageRoute(builder: (context) => AuthorDetail(authorId: '${booksSearchList[0]['AuthorID']}' , id: widget.id,));
              Navigator.push(context, route);
            },),
            const SizedBox(height: TSizes.spaceBtwInputFields,),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(200)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 64, 64, 64),
                    offset: Offset(5, 5),
                    blurRadius: 10
                  )
                ]
              ),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image(
                    width: 200,
                    height: 200,
                    image: AssetImage('assets/images/Products/${booksSearchList[0]['ImageURL']}') , fit: BoxFit.fill,),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text( textAlign: TextAlign.center,'${booksSearchList[0]['description']}' , style: Theme.of(context).textTheme.labelLarge , maxLines: 10,),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),

          ],
        ),
      )
    );
  }
}