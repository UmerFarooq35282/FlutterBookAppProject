import 'package:flutter/material.dart';

class CustomerDetsProvider extends ChangeNotifier{
  // Map<String , Map<String , dynamic>> customer = {};

  List<dynamic> customer = [];

  void addCustomer(List<dynamic> customerDets){
    if(customerDets.isNotEmpty){
      customer.add(customerDets);
    }else{
      customer[0] = {
        "Name" : 'Guest'
      };
    }
    notifyListeners();
    // String name = customerDets['Name'];

    // customer[name] = {
    //   "CustomerID": customerDets['CustomerID'],
    //   "Name": customerDets['Name'],
    //   "Email": customerDets['Email'],
    //   "Phone": customerDets['Phone'],
    //   "Address": customerDets['Address'],
    //   "ImageURL": customerDets['ImageURL'],
    //   "Role": customerDets['Role'],
    //   "password": customerDets['password'],
    //   "Gender": customerDets['Gender']
      
    // };
  }

}