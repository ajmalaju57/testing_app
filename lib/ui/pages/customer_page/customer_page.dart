import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eco/data/models/customers_list_model.dart';
import 'package:test_eco/ui/components/app_bar_custom.dart';
import 'package:test_eco/ui/components/app_cached_image.dart';
import 'package:test_eco/ui/components/app_svg.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/ui/components/app_text_field.dart';
import 'package:test_eco/ui/components/btn_primary_gradient.dart';
import 'package:test_eco/ui/components/dividers.dart';
import 'package:test_eco/ui/pages/customer_page/cubit/customer_page_cubit.dart';
import 'package:test_eco/ui/pages/product_page/product_page.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/extensions/margin_ext.dart';
import 'package:test_eco/utils/shared/page_navigator.dart';
import 'package:test_eco/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key, required this.title, this.isNewOrder = false});
  final String title;
  final bool isNewOrder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: title,
      ),
      body: BlocProvider(
        create: (context) => CustomerPageCubit(context),
        child: BlocBuilder<CustomerPageCubit, CustomerPageState>(builder: (context, state) {
          final cubit = context.read<CustomerPageCubit>();
          return Column(
            // padding: const EdgeInsets.only(bottom: 30),
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
                      cubit.searchCustomer();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                      border: const UnderlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.qr_code_2_sharp, color: primaryColor),
                          isNewOrder ? 0.wBox : 5.wBox,
                          isNewOrder
                              ? 0.hBox
                              : GestureDetector(
                                  onTap: () {
                                    bottumsheet(context, false, cubit);
                                    cubit.updateCustomervalEmpty();
                                  },
                                  child: const Icon(Icons.add_circle, color: primaryColor, size: 22),
                                ),
                          isNewOrder ? 0.wBox : 5.wBox,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              state is CustomersDataLoaded
                  ? state.data!.isEmpty
                      ? const Center(
                          child: AppText("No data"),
                        )
                      : Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListView.builder(
                                itemCount: state.data?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final details = state.data?[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.grey.withOpacity(0.3))),
                                      child: ListTile(
                                        // dense: false,
                                        onTap: isNewOrder
                                            ? () {
                                                Screen.open(
                                                    context,
                                                    ProductPage(
                                                      title: details?.name ?? "",
                                                    ));
                                              }
                                            : () {
                                                bottumsheet(context, true, cubit, details: details);
                                                cubit.updateCustomerValues(details: details);
                                              },
                                        visualDensity: const VisualDensity(horizontal: 2, vertical: 4),
                                        tileColor: colorWhite,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        leading: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AspectRatio(
                                                aspectRatio: 1.4,
                                                child: CachedImage(
                                                  imageUrl: "${details?.profilePic}",
                                                )),
                                            15.wBox,
                                            CustomPaint(
                                              size: const Size(4, 200),
                                              painter: CurvePainter(),
                                            )
                                          ],
                                        ),
                                        title: Row(
                                          children: [
                                            AppText(details?.name, family: inter600, size: 14),
                                            Expanded(child: 0.wBox),
                                            GestureDetector(
                                                onTap: () {
                                                  makePhoneCall(details!.mobileNumber.toString());
                                                },
                                                child: const Icon(
                                                  Icons.call_outlined,
                                                  color: primaryColor,
                                                )),
                                            8.wBox,
                                            GestureDetector(
                                                onTap: () {
                                                  _launchWhatsApp(details!.mobileNumber.toString());
                                                },
                                                child: const AppSvg(assetName: "whatsapp", color: Colors.green, height: 20, width: 20))
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppText("ID:${details?.id}", color: Colors.grey.withOpacity(0.8), family: inter500, size: 12),
                                            AppText("${details?.street}, ${details?.city}, ${details?.state}", color: Colors.grey.withOpacity(0.8), family: inter500, size: 12),
                                            RichText(
                                              text: const TextSpan(
                                                text: "Due Amount:",
                                                style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: inter600),
                                                children: [
                                                  TextSpan(text: "\$234/-", style: TextStyle(color: Colors.red, fontSize: 14, fontFamily: inter600)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                  : const Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ],
          );
        }),
      ),
    );
  }
}

Future<void> makePhoneCall(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  await launchUrl(launchUri);
}

Future<void> _launchWhatsApp(
  String number,
) async {
  final url = Uri.parse('http://wa.me/91$number/');
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

bottumsheet(BuildContext context, bool isUpdate, CustomerPageCubit cubit, {Data? details}) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.8),
    constraints: BoxConstraints(maxHeight: context.device.size.height / 1.3, minWidth: double.infinity),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    )),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: Container(
          decoration: const BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          child: Scaffold(
            body: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Form(
                key: cubit.step1FormKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText("Add costomer", family: inter600, size: 14),
                        GestureDetector(
                            onTap: () {
                              Screen.closeDialog(context);
                            },
                            child: const Icon(Icons.cancel_outlined, size: 25, color: primaryColor)),
                      ],
                    ),
                    AppTextField(
                        label: "Customer Name",
                        hint: "customer name",
                        controller: cubit.customerNameCtrl,
                        validator: (value) {
                          return value.isEmpty ? "Enter Customer Name" : null;
                        }),
                    AppTextField(
                      label: "Mobile Number",
                      hint: "mobile number",
                      controller: cubit.numberCtrl,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        return value.isEmpty ? "Enter Mobile Number" : null;
                      },
                    ),
                    AppTextField(
                      label: "Email",
                      hint: "Enter email",
                      controller: cubit.emailCtrl,
                      validator: (value) => cubit.emailValidator(value),
                    ),
                    10.hBox,
                    const AppText("Address", family: inter600, size: 14),
                    Row(
                      children: [
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "street",
                              hint: "street",
                              controller: cubit.streetCtrl,
                              validator: (value) {
                                return value.isEmpty ? "Enter street" : null;
                              },
                            )),
                        Expanded(child: 0.wBox),
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "street 2",
                              hint: "street 2",
                              controller: cubit.street2Crtl,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "city",
                              hint: "city",
                              controller: cubit.cityCrtl,
                              validator: (value) {
                                return value.isEmpty ? "Enter city" : null;
                              },
                            )),
                        Expanded(child: 0.wBox),
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "pin code",
                              hint: "pin code",
                              controller: cubit.pinCodeCrtl,
                              validator: (value) {
                                return value.isEmpty ? "Enter pin code" : null;
                              },
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "country",
                              hint: "country",
                              controller: cubit.countyCrtl,
                              validator: (value) {
                                return value.isEmpty ? "Enter country" : null;
                              },
                            )),
                        Expanded(child: 0.wBox),
                        SizedBox(
                            width: 160,
                            child: AppTextField(
                              label: "state",
                              hint: "state",
                              controller: cubit.stateCrtl,
                              validator: (value) {
                                return value.isEmpty ? "Enter state" : null;
                              },
                            )),
                      ],
                    ),
                    20.hBox,
                    UnconstrainedBox(
                      child: BtnPrimaryGradient(
                        onTap: () {
                          isUpdate ? cubit.updateCustomer(details) : cubit.addNewCustomer();
                        },
                        text: isUpdate ? "Update" : "submit",
                        bgColor: primaryColor,
                        textColor: colorWhite,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
