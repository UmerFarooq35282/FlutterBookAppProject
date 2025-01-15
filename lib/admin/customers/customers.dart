import 'dart:convert';

import 'package:book_store/admin/admin.dart';
import 'package:book_store/admin/customers/profile.dart';
import 'package:book_store/admin/customers/update_customer.dart';
// import 'package:book_store/admin/Customers/a';
import 'package:book_store/common/widgets/products/custom_search.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  List customers = [];
  String msg = '';
  Future<http.Response> _getCustomers() async {
    final http.Response response =
        await Network().postData({'O': '0' , 'S' : '1000'}, '/getCustomers.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        customers = res['customers'];
      });
    });
    return response;
  }
  Future<http.Response> _deleteAuthor(String id) async {
    final http.Response response =
        await Network().postData({'id': id}, '/deleteCustomers.php');

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

  Future<http.Response> _getCustomersByName(String catName) async {
    final http.Response response =
        await Network().postData({'name': catName}, '/getCustomersByName.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        customers = res['customers'];
      });
    });
    return response;
  }
  @override
  void initState() {
    super.initState();
    _getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchWidget(onPressedFn: (){
          }, onChanged: (value) {
            _getCustomersByName(value);
          },),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: customers.length,
          itemBuilder: (context, index) {
          final customer = customers[index];
          return AdminPanelCard(
            showActions: true,
            deleteOnPress: (){
              _showConfirmationDailog(customer['CustomerID']);
            },
            updateOnPress: (){
              final route = MaterialPageRoute(builder: (context) => UpdateCustomerScreen(id: customer['CustomerID'],));
              Navigator.push(context, route);
            },
            applyMargin: true,
            title: customer['Name'], 
            subTitle: customer['Email'], 
            icon: const Icon(Iconsax.user), 
            onTap: (){
              final route = MaterialPageRoute(builder: (context) => ProfileScreen(id: customer['CustomerID'],));
              Navigator.push(context, route);
              print(customer['CustomerID']);
            }
          );
        },) 
    );

  }

  
}
