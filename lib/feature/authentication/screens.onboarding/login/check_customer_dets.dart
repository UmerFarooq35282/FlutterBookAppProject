import 'package:book_store/feature/shop/controller/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDets extends StatelessWidget {
  const CustomerDets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDetsProvider>(
      builder: (context, customerDetail, child) =>   Scaffold(
        body: Center(
          child: Text('${customerDetail.customer}'),
        ),
      ),
    );
  }
}