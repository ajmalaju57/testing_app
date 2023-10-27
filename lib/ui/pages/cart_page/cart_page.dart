// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eco/ui/components/app_bar_custom.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/components/btn_primary_gradient.dart';
import 'package:test_eco/ui/pages/cart_page/print_page.dart';
import 'package:test_eco/ui/pages/product_page/components/cubit/product_add_container_cubit.dart';
import 'package:test_eco/ui/pages/product_page/components/product_add_container.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/extensions/margin_ext.dart';
import 'package:test_eco/utils/shared/page_navigator.dart';
import 'package:test_eco/utils/strings.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppbar(
        isBackBtn: false,
        title: "Your Cart",
      ),
      body: BlocProvider(
        create: (context) => ProductAddContainerCubit(0),
        child: BlocBuilder<ProductAddContainerCubit, ProductAddContainerState>(
          builder: (context, state) {
            final cubit = context.read<ProductAddContainerCubit>();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              shrinkWrap: true,
              children: [
                state is AddToCartDataLoaded
                    ? state.box.isEmpty
                        ? const Center(child: AppText("No Cart items"))
                        : ListView.separated(
                            itemCount: state.box.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final data = state.box[index];
                              return ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  AppText(data.customerName,
                                      color: Colors.black,
                                      family: inter500,
                                      align: TextAlign.center),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: AppText("${data.productName} | 250g",
                                        color: Colors.black, family: inter600),
                                    subtitle: AppText("\$${data.price}",
                                        color: txtGrey,
                                        size: 12,
                                        family: inter500),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Counter(
                                            selectProductCount: data.quantity,
                                            isCartPage: true,
                                            id: data.id,
                                            cartData: data),
                                        10.wBox,
                                        GestureDetector(
                                          onTap: () {
                                            cubit
                                                .deleteItem(int.parse(data.id));
                                          },
                                          child: const Icon(Icons.delete,
                                              color: Colors.red, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            })
                    : 5.hBox,
                20.hBox,
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppText("SubTotal",
                                size: 12, family: inter500),
                            state is AddToCartDataLoaded
                                ? AppText("\$${state.totalPrice}",
                                    size: 12, family: inter500)
                                : const AppText("\$0.00",
                                    size: 12, family: inter500),
                          ],
                        ),
                        15.hBox,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText("Tax", size: 12, family: inter500),
                            AppText("\$50.0", size: 12, family: inter500),
                          ],
                        ),
                        10.hBox,
                        const Divider(),
                        10.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppText("Total", size: 14, family: inter600),
                            state is AddToCartDataLoaded
                                ? AppText("\$${state.totalTaxPrice}",
                                    size: 14, family: inter500)
                                : const AppText("\.00",
                                    size: 14, family: inter500),
                          ],
                        ),
                        20.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: BtnPrimaryGradient(
                              onTap: () {},
                              text: "Order",
                              bgColor: primaryColor,
                              textColor: colorWhite,
                              borderRadius: 16,
                              height: 40,
                            )),
                            20.wBox,
                            Expanded(
                                child: BtnPrimaryGradient(
                              onTap: () {
                                state is AddToCartDataLoaded
                                    ? Screen.open(context, PrintPage(state.box))
                                    : null;
                              },
                              height: 40,
                              text: "Order & Delivery",
                              bgColor: primaryColor,
                              textColor: colorWhite,
                              borderRadius: 16,
                            )),
                          ],
                        )
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
