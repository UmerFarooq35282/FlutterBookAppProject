import 'dart:convert';

import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/feature/shop/screens/home/home.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../controller/NetworkHelper.dart';

class AuthorDetail extends StatefulWidget {
  const AuthorDetail({super.key, required this.authorId, this.id = '0'});
  final String authorId;
  final String id;
  @override
  State<AuthorDetail> createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {

  List authorList = [];
  List booksbyAuthor = [];

  Future<http.Response> _getAuthorDetail() async {
    final http.Response response = await Network().postData({
      "id": widget.authorId
    }, '/getAuthorById.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authorList = res['Author'];
      });
    });
    return response;
  }
  Future<http.Response> _getBooksByAuthor() async {
    final http.Response response = await Network().postData({
      "id": widget.authorId
    }, '/getBookByAuthId.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        booksbyAuthor = res['books'];
      });
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAuthorDetail();
    _getBooksByAuthor();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showDefaultLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
          child: Column(
            children: [
              CustomHeadingWidget(title: authorList[0]['author_name'], btnText: ''),
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
                      image: AssetImage('assets/images/Authors/${authorList[0]['image_url']}') , fit: BoxFit.fill,),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text( textAlign: TextAlign.center,'${authorList[0]['bio']}' , style: Theme.of(context).textTheme.labelLarge , maxLines: 10,),
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              CustomHeadingWidget(title: "${authorList[0]['author_name']}'s books", btnText: ''),
              HomeGridViewWidget(booksList: booksbyAuthor , id: widget.id,),
            ],
          ),
        ),
      )
    );
  }
}