import 'dart:convert';

import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/common/widgets/products/vertical_cart.dart';
import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/feature/shop/models/customer.dart';
import 'package:book_store/feature/shop/screens/store/products/produc.dart';
import 'package:book_store/feature/shop/screens/store/products/product_detail.dart';
// import 'package:book_store/utils/constants/colors.dart';
// import 'package:book_store/utils/constants/colors.dart';
import 'package:book_store/utils/constants/sizes.dart';

// import '/common/widgets/custom_shapes/containers/circular_container.dart';
// import '/common/widgets/custom_shapes/curved_shapes/curved_path.dart';
// import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.id, this.role = ''});

  final String title;
  final String id;
  final String role;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String bookName = '';
  int pageCount = 0;
  int pageSize = 16;

  int pageNumber1 = 0;
  late List categories = [];
  late List allBooks = [];
  late List books = [];
  late List booksSearchList = [];

  List<Customer> customer = [];

  Future<http.Response> _getCategories() async {
    final http.Response response =
        await Network().postData({"O": "0", "S": "15"}, '/getCategories.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        categories = res['categories'];
      });
    });
    return response;
  }

  Future<http.Response> _getBooksByCat() async {
    final http.Response response = await Network()
        .postData({"name": name, "O": '0', "S": '16'}, '/getBookByCat.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        books = res['books'];
      });
    });
    return response;
  }
  Future<http.Response> _getBooks(String catName) async {
    final http.Response response = await Network()
        .postData({"name": catName, "O": '$pageCount', "S": '$pageSize'}, '/getBookByCat.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        books = res['books'];
      });
    });
    return response;
  }

  Future<http.Response> _getAllBooks() async {
    final http.Response response = await Network().getData('/getBooks.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        allBooks = res['books'];
        pageNumber1 = (allBooks.length / 16).floor();
      });
    });
    return response;
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
    super.initState();
    _getCategories();
    _getBooks(name);
    _getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(
        showCartIcon: true,
        id: widget.id,
        isLogedIn: widget.id != '0' ? true : false,
        isAdmin: widget.role == 'admin' ? true : false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title != '' ? widget.title : 'Guest',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Welcome to our Ebook Shop",
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SearchWidget(onPressedFn: (){}, onChanged: (val){
                    _getBooksBySearch(val);
                  }),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const CustomHeadingWidget(
                    title: 'Categories',
                    btnText: '',
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category = categories[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              name = category['name'];
                              _getBooksByCat();
                              print(category['name']);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(children: [
                              Container(
                                width: 56,
                                height: 56,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/${category['image']}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields / 2,
                              ),
                              SizedBox(
                                width: 55,
                                child: Text(
                                  "${category['name']}",
                                  style: Theme.of(context).textTheme.labelLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              )
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  CustomHeadingWidget(
                    title: 'Products',
                    btnText: 'View All',
                    btnOnPressed: () {
                      final route = MaterialPageRoute(
                          builder: (context) =>  ProductsScreen(id: widget.id,));
                      Navigator.push(context, route);
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  HomeGridViewWidget(
                    id: widget.id,
                    booksList: books,
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

class HomeGridViewWidget extends StatelessWidget {
  const HomeGridViewWidget({
    super.key,
    required this.booksList,  this.id = '',
  });
  final List booksList;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GridView.builder(
              itemCount: booksList.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 288,
              ),
              itemBuilder: (_, index) {
                var book = booksList[index];
                return VerticalCardWidget(
                  id: id,
                  onTap: () {
                    final route = MaterialPageRoute(
                        builder: (contxet) =>
                            ProductDetail(bookId: '${book['BookID']}'));
                    Navigator.push(context, route);
                  },
                  book: book,
                  showheartIconFn: () {},
                );
              }),
        ],
      ),
    );
  }
}
