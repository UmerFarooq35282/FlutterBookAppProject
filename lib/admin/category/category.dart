import 'dart:convert';
import 'package:book_store/admin/category/add_category.dart';
import 'package:book_store/admin/category/update_book.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List categories = [];

  Future<http.Response> _getAllCategories() async {
    final http.Response response = await Network()
        .postData({"O": '0', "S": '16'}, '/getCategories.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        categories = res['categories'];
      });
    });
    return response;
  }

  Future<http.Response> _getCategoriesBySearch(String catName) async {
    final http.Response response = await Network().postData(
        {"name": catName,}, '/getCategoryByname.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        categories = res['categories'];
      });
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getCategoriesByCat();
    _getAllCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(
                onPressedFn: () {},
                onChanged: (value) {
                  _getCategoriesBySearch(value);
                },
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              CustomHeadingWidget(
                btnOnPressed: (){
                  final route = MaterialPageRoute(builder: (context) => const AddCategoryPage());
                  Navigator.push(context, route);
                },
                btnText: 'Add Category',
                title: 'Categories',
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              AdminGridViewWidget(bookList: categories,)
            ],
          ),
        ),
      ),
    );
  }
}

class AdminGridViewWidget extends StatelessWidget {
  const AdminGridViewWidget({
    super.key, required this.bookList,
  });
  final List bookList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GridView.builder(
              itemCount: bookList.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 288,
              ),
              itemBuilder: (_, index) {
                var book = bookList[index];
                return AdminVerticalCard(book: book,);
              }),
        ],
      ),
    );
  }
}

class AdminVerticalCard extends StatefulWidget {
  const AdminVerticalCard({
    super.key, required this.book,
  });
  final Map<String, dynamic> book;

  @override
  State<AdminVerticalCard> createState() => _AdminVerticalCardState();
}

class _AdminVerticalCardState extends State<AdminVerticalCard> {

   String msg = '';
  Future<http.Response> _deleteCategory() async {
    final http.Response response =
        await Network().postData({'id': '${widget.book['id']}'}, '/deleteCategory.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
        
      });
    });
    return response;
  }
  void _showConfirmationDailog(){
    
    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Information' , style: TextStyle(
          color: Colors.black , fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("Do you Reallu Want to delete this Category" , style: TextStyle(
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
            _deleteCategory();
            final route = MaterialPageRoute(builder: (context) => const CategoriesPage());
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
      onTap: (){},
      child: Container(
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
                      'assets/images/${widget.book['image']}')),
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
                          widget.book['name'],
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 00,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                         "${widget.book['description']}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                  Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final route = MaterialPageRoute(builder: (context) =>  UpdateCategoryPage(book: widget.book,));
                              Navigator.push(context, route);
                            },
                            icon: const Icon(
                              Iconsax.setting,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _showConfirmationDailog();
                              },
                              icon: const Icon(Iconsax.trash)),
                        ],
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
