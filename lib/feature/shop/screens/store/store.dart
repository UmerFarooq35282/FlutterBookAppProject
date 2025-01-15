import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/common/widgets/products/horizontal_card.dart';
// import 'package:book_store/utils/constants/colors.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class StoreScreeen extends StatelessWidget {
  const StoreScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        actions: [CustomCartWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (_ , index){
            return const HorizontalCardWidget(list: {},);
          }
        )
      ),
    );
  }
}


