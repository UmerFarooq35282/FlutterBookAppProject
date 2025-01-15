import 'dart:convert';

import 'package:book_store/admin/books/add_book.dart';
import 'package:book_store/admin/books/update_book.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List books = [];


  Future<http.Response> _getBooksByCat() async {
    final http.Response response = await Network()
        .postData({"name": '', "O": '0', "S": '16'}, '/getBookByCat.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        books = res['books'];
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
        content: const Text("click okay to insert this record" , style: TextStyle(
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
            ();
            Navigator.pop(context);
          }, child: const Text('Okay')),),
            ],
          )
        ],
      );
    },);
  }
  Future<http.Response> _getBooksBySearch(String bookName) async {
    final http.Response response = await Network().postData(
        {"name": bookName, 'O': '0', 'S': '15'}, '/getBookByName.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        books = res['books'];
      });
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBooksByCat() ;
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
                  _getBooksBySearch(value);
                },
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              CustomHeadingWidget(
                btnOnPressed: (){
                  final route = MaterialPageRoute(builder: (context) => const AddBookPage());
                  Navigator.push(context, route);
                },
                btnText: 'Add book',
                title: 'Books',
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              AdminGridViewWidget(bookList: books,)
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

class AdminVerticalCard extends StatelessWidget {
  const AdminVerticalCard({
    super.key, required this.book,
  });
  final Map<String, dynamic> book;
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
                      'assets/images/Products/${book['images']}')),
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
                          book['Title'],
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
                    children: [
                      Text(
                        book['name'],
                        style:
                            Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       "${book['Price']}",
                        style:
                            Theme.of(context).textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final route = MaterialPageRoute(builder: (context) =>  UpdateBookPage(book: book,));
                              Navigator.push(context, route);
                            },
                            icon: const Icon(
                              Iconsax.setting,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                
                              },
                              icon: const Icon(Iconsax.trash)),
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
