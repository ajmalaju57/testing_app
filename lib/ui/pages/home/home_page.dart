import 'package:flutter/material.dart';
import 'package:test_eco/ui/components/app_bar_custom.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/pages/customer_page/customer_page.dart';
import 'package:test_eco/ui/pages/product_page/product_page.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/extensions/margin_ext.dart';
import 'package:test_eco/utils/shared/page_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const menus = [
      "Customers",
      "Products",
      "New Order",
      "Return Order",
      "Add Payment",
      "Today's Order",
      "Today's Summery",
      "Route",
    ];

    List<IconData> menusIcons = [
      Icons.people,
      Icons.poll_rounded,
      Icons.addchart,
      Icons.keyboard_return,
      Icons.payments,
      Icons.topic_rounded,
      Icons.summarize,
      Icons.route
    ];
    return Scaffold(
      appBar: const AppAppbar(
        isHomePage: true,
      ),
      body: GridView.count(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: List.generate(menus.length, (index) {
            return InkWell(
              onTap: () => onMenuClicked(context, index: index),
              child: Container(
                decoration: _decoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      menusIcons[index],
                      color: primaryColor,
                      size: 35,
                    ),
                    15.hBox,
                    AppText(
                      menus[index],
                      color: textColor,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            );
          }, growable: false)),
    );
  }
}

BoxDecoration _decoration() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: gridShadow, blurRadius: 16, offset: Offset(0, 4))
      ]);
}

onMenuClicked(BuildContext context, {required int index}) {
  switch (index) {
    case 0:
      Screen.open(
        context,
        const CustomerPage(title: "Customers"),
      );
      break;
    case 1:
      Screen.open(
          context,
          const ProductPage(
            title: "Products",
          ));
      break;
  }
}
