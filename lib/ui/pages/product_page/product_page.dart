import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eco/ui/components/app_bar_custom.dart';
import 'package:test_eco/ui/components/app_cached_image.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/components/dividers.dart';
import 'package:test_eco/ui/pages/product_page/components/product_add_container.dart';
import 'package:test_eco/ui/pages/product_page/cubit/product_page_cubit.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/extensions/margin_ext.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: title, isBackBtn: true),
      body: BlocProvider(
        create: (context) => ProductPageCubit(context),
        child: BlocBuilder<ProductPageCubit, ProductPageState>(
          builder: (context, state) {
            final cubit = context.read<ProductPageCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withOpacity(0.6), width: 0.9),
                  ),
                  child: Center(
                    child: TextField(
                      controller: cubit.searchCtrl,
                      onChanged: (value) {
                        cubit.searchProduct();
                      },
                      decoration: const InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.qr_code_2_sharp, color: Colors.grey),
                            VerticalDivider(endIndent: 10, indent: 10, color: Colors.grey),
                            AppText("fruts", color: Colors.grey),
                            Icon(Icons.expand_more_rounded, color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // 10.hBox,
                Expanded(
                  child: state is ProductDataLoaded
                      ? state.data!.isEmpty
                          ? const Center(child: AppText("No Data"))
                          : ListView(
                              shrinkWrap: true,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.data?.length,
                                  padding: const EdgeInsets.only(right: 12, left: 12, bottom: 18),
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    final data = state.data![index];
                                    return Card(
                                      elevation: 5,
                                      margin: EdgeInsets.zero,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: colorWhite,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Column(
                                          children: [
                                            7.hBox,
                                            CachedImage(
                                              imageUrl: '${data.image}',
                                              height: 80,
                                            ),
                                            20.hBox,
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 60,
                                                        child: AppText(
                                                          data.name,
                                                          color: const Color.fromARGB(234, 61, 60, 60),
                                                          size: 12,
                                                          weight: FontWeight.w500,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      AppText(
                                                        "\$${data.price}/-",
                                                        color: Colors.black45,
                                                        size: 12,
                                                        weight: FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                  CustomPaint(
                                                    size: const Size(4.5, 50),
                                                    painter: CurvePainter(),
                                                  ),
                                                  Counter(data: data, customerName: title),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                      : const Center(child: CupertinoActivityIndicator()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
