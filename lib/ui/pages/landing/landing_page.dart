import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/components/bottom_bar_custom.dart';
import 'package:test_eco/ui/pages/cart_page/cart_page.dart';
import 'package:test_eco/ui/pages/customer_page/customer_page.dart';
import 'package:test_eco/ui/pages/home/home_page.dart';
import 'package:test_eco/ui/pages/landing/landing_cubit.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, this.selectedIndex = 0}) : super(key: key);

  final int selectedIndex;
  static const pages = [
    HomePage(),
    CustomerPage(title: "New Order", isNewOrder: true),
    CartPage(),
    Center(child: AppText("Return Order")),
    CustomerPage(title: "Customers"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingCubit(selectedIndex),
      child: BlocBuilder<LandingCubit, LandingState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(child: pages[state.currentIndex]),
              bottomNavigationBar:
                  AppBottomNav(currentIndex: state.currentIndex));
        },
      ),
    );
  }
}
