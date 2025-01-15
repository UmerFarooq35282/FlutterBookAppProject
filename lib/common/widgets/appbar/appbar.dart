import 'dart:convert';

import 'package:book_store/admin/admin.dart';
import 'package:book_store/feature/authentication/screens.onboarding/login/login.dart';
import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/feature/shop/screens/addToCart/addto_cart.dart';
import 'package:book_store/feature/shop/screens/profile/profile.dart';
import 'package:book_store/feature/shop/screens/setting/setting.dart';
import 'package:book_store/utils/constants/colors.dart';
// import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.showleading = false,
    this.leadingIcon,
    this.leadingOnPressed,
    this.actions,
    this.showDefaultLeading = false,
    this.isLogedIn = false,
    this.isAdmin = false,
    this.id = '', this.showCartIcon = true,
  });

  final Widget? title;
  final List<Widget>? actions;
  final bool showleading;
  final Widget? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final bool showDefaultLeading;
  final bool isLogedIn;
  final bool isAdmin;
  final String id;
  final bool showCartIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: AppBar(
          automaticallyImplyLeading: showDefaultLeading,
          leading: showleading
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Iconsax.arrow_left))
              : leadingIcon != null
                  ? IconButton(
                      onPressed: leadingOnPressed, icon: leadingIcon!)
                  : null,
          title: title,
          actions: [
            showCartIcon ?
            CustomCartWidget(
              id: id,
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) =>  CartScreen(id: id,));
                Navigator.push(context, route);
              },
            ) : const Text(''),
            showCartIcon ? PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        onTap: () {
                          final route = MaterialPageRoute(
                              builder: (context) =>  ProfileScreen(id: id,));
                          Navigator.push(context, route);
                        },
                        child: Row(
                          children: [
                            const Icon(Iconsax.user),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Profile',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )),
                    PopupMenuItem(
                        onTap: () {
                          final route = MaterialPageRoute(
                              builder: (context) => SettingScreen(id: id,));
                          Navigator.push(context, route);
                        },
                        child: Row(
                          children: [
                            const Icon(Iconsax.setting),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Setting',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )),
                    PopupMenuItem(
                        onTap: () {
                          final route = MaterialPageRoute(
                              builder: (context) => const LoginScreen());
                          Navigator.push(context, route);
                        },
                        child: Row(
                          children: [
                            const Icon(Iconsax.logout),
                            const SizedBox(
                              width: 10,
                            ),
                            isLogedIn
                                ? Text(
                                    'LogOut',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                : Text(
                                    'LogIn',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                          ],
                        )),
                    PopupMenuItem(
                       enabled: isAdmin ? true : false,
                        onTap: () {
                          final route = MaterialPageRoute(
                              builder: (context) => const AdminScreen());
                          Navigator.push(context, route);
                        },
                        child: Row(
                          children: [
                            const Icon(Iconsax.user),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'AdminPanel',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )),
                  ];
                },
                icon: const Icon(Iconsax.more)) : Text('')
          ]),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomCartWidget extends StatefulWidget {
  const CustomCartWidget({
    super.key,
    this.onPressed,
     this.id = '',
  });
  final VoidCallback? onPressed;
  final String id;
  @override
  State<CustomCartWidget> createState() => _CustomCartWidgetState();
}

class _CustomCartWidgetState extends State<CustomCartWidget> {
  List books = [];

  Future<http.Response> _getTotalCardNumber() async {
    final http.Response response =
        await Network().postData({"id": widget.id}, '/getTotalCartItem.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      if (res['items'] != []) {
        setState(() {
          books = res['items'];
        });
      } else {
        books = [
          {"totalNumber": "0"}
        ];
      }
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getTotalCardNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(
              Iconsax.shopping_bag,
              color: TColors.darkerGrey,
            )),
      ],
    );
  }
}
