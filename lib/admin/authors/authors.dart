import 'dart:convert';

import 'package:book_store/admin/admin.dart';
import 'package:book_store/admin/authors/add_authors.dart';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  List authors = [];
  String msg = '';
  Future<http.Response> _getAuthors() async {
    final http.Response response =
        await Network().postData({'name': ''}, '/getAuthors.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
      });
    });
    return response;
  }
  Future<http.Response> _deleteAuthor(String id) async {
    final http.Response response =
        await Network().postData({'id': id}, '/deleteAuthors.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
      });
    });
    return response;
  }

   void _showConfirmationDailog(String id){
    
    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Information' , style: TextStyle(
          color: Colors.black , fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("Do You really Want to Delete this Author" , style: TextStyle(
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
            _deleteAuthor(id);
            Navigator.pop(context);
          }, child: const Text('Okay')),),
            ],
          )
        ],
      );
    },);
  }

  Future<http.Response> _getAuthorsByName(String catName) async {
    final http.Response response =
        await Network().postData({'name': catName}, '/getAuthorByName.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
      });
    });
    return response;
  }
  @override
  void initState() {
    super.initState();
    _getAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchWidget(onPressedFn: (){
            
          }, onChanged: (value) {
            _getAuthorsByName(value);
          },),
          actions: [
            ElevatedButton(onPressed: (){
              final route = MaterialPageRoute(builder: (context) => const AddAuthorsPage());
            Navigator.push(context, route);
            }, child: const Text('Add Authors'))
          ],
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: authors.length,
          itemBuilder: (context, index) {
          final author = authors[index];
          return AdminPanelCard(
            showActions: true,
            deleteOnPress: (){
              _showConfirmationDailog(author['id']);
            },
            updateOnPress: (){
              
            },
            applyMargin: true,
            title: author['author_name'], 
            subTitle: author['bio'].toString().substring(0, 25), 
            icon: const Icon(Iconsax.user), 
            onTap: (){}
          );
        },) 
    );

  }

  
}
