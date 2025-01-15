import 'package:book_store/admin/authors/authors.dart';
import 'package:book_store/admin/books/books.dart';
import 'package:book_store/admin/category/category.dart';
import 'package:book_store/admin/customers/customers.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<String> tabsName = ["Books", "Category", "Authors", "Users"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin Panel",
              style: Theme.of(context).textTheme.displayMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        AdminPanelCard(
          title: 'Books',
          subTitle: 'Click Here to check books',
          icon: const Icon(Iconsax.book),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const BooksPage());
            Navigator.push(context, route);
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        AdminPanelCard(
          title: 'Category',
          subTitle: 'Click Here to check Categories',
          icon: const Icon(Iconsax.briefcase),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const CategoriesPage());
            Navigator.push(context, route);
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        AdminPanelCard(
          title: 'Authors',
          subTitle: 'Click Here to check Authors',
          icon: const Icon(Iconsax.user),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const AuthorsPage());
            Navigator.push(context, route);
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        AdminPanelCard(
          title: 'Users',
          subTitle: 'Click Here to check users',
          icon: const Icon(Iconsax.user),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const CustomersPage());

            Navigator.push(context, route);
          },
        ),
      ]),
    );
  }
}

class AdminPanelCard extends StatelessWidget {
  const AdminPanelCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTap, 
    this.applyMargin = false, this.showActions = false, 
    this.deleteOnPress ,
    this.updateOnPress
  });

  final String title;
  final String subTitle;
  final bool applyMargin;
  final Widget icon;
  final VoidCallback onTap;
  final bool showActions;
  final VoidCallback? deleteOnPress;
  final VoidCallback? updateOnPress;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
        child: Container(
          margin: applyMargin ? const EdgeInsets.symmetric(vertical: 10) : const EdgeInsets.symmetric(vertical: 0),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(child: IconButton(onPressed: null, icon: icon)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.black : Colors.white)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(subTitle,
                        style: TextStyle(
                            color: isDark ? Colors.black : Colors.white)),
                    showActions ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: updateOnPress, icon: Icon(Iconsax.setting , color: isDark ? Colors.black : Colors.white,)),
                        IconButton(onPressed: deleteOnPress, icon: Icon(Iconsax.trash , color: isDark ? Colors.black : Colors.white,)),
                      ],
                    ) : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
