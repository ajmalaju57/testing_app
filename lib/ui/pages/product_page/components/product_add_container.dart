import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eco/data/models/cart_items_model.dart';
import 'package:test_eco/data/models/products_list_model.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/components/btn_primary_gradient.dart';
import 'package:test_eco/ui/pages/product_page/components/cubit/product_add_container_cubit.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/strings.dart';

class Counter extends StatelessWidget {
  const Counter({super.key, this.selectProductCount = 0, this.data, this.customerName, this.isCartPage = false, this.id, this.cartData});
  final int selectProductCount;
  final Data? data;
  final CartItem? cartData;
  final String? customerName, id;
  final bool isCartPage;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductAddContainerCubit(selectProductCount),
      child: BlocBuilder<ProductAddContainerCubit, ProductAddContainerState>(
        builder: (context, state) {
          final cubit = context.read<ProductAddContainerCubit>();
          return Container(
            child: cubit.productCount == 0
                ? BtnPrimaryGradient(
                    width: 70,
                    height: 30,
                    onTap: () {
                      cubit.increment();
                      cubit.addItem(
                          CartItem(id: data!.id.toString(), productName: data!.name.toString(), price: data!.price!.toDouble(), quantity: cubit.productCount, customerName: customerName.toString()));
                    },
                    text: "Add",
                    fontSize: 14,
                    bgColor: primaryColor,
                    borderRadius: 5,
                    family: inter600,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.decreaseCartItemQuantity(isCartPage ? id.toString() : data!.id.toString());
                          // cubit.deleteItem(int.parse(id.toString()));
                        },
                        child: Container(
                            width: 20,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                )),
                            child: const AppText("-", family: inter600, color: colorWhite, size: 18)),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Center(
                          child: AppText(
                            cubit.productCount,
                            family: inter600,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.increaseCartItemQuantity(isCartPage ? id.toString() : data!.id.toString());
                          // cubit.addItem(CartItem(
                          //     productName: data!.name.toString(),
                          //     price: data!.price!.toDouble(),
                          //     quantity: cubit.productCount,
                          //     customerName: customerName.toString()));
                        },
                        child: Container(
                            width: 20,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                )),
                            child: const AppText("+", family: inter600, color: colorWhite, size: 18)),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
