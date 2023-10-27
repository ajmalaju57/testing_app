// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_eco/data/models/customers_list_model.dart';
import 'package:test_eco/data/services/api.dart';
import 'package:test_eco/data/services/urls.dart';
import 'package:test_eco/utils/shared/app_snackbar.dart';
import 'package:test_eco/utils/shared/page_navigator.dart';

part 'customer_page_state.dart';

class CustomerPageCubit extends Cubit<CustomerPageState> {
  CustomerPageCubit(this.context) : super(CustomerPageInitial()) {
    init();
  }
  init() async {
    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getCustomerList();
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status$e');
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    debugPrint(_connectionStatus.toString());
    if (_connectionStatus == ConnectivityResult.none) {
      snackBar(context,
          message: "Network seems to be Offline", type: MessageType.error);
    } else {
      // snackBar(context,
      //     message: "Network seems to be Online", type: MessageType.success);
    }
  }

  BuildContext context;
  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();
  TextEditingController searchCtrl = TextEditingController(),
      customerNameCtrl = TextEditingController(),
      numberCtrl = TextEditingController(),
      emailCtrl = TextEditingController(),
      streetCtrl = TextEditingController(),
      street2Crtl = TextEditingController(),
      cityCrtl = TextEditingController(),
      pinCodeCrtl = TextEditingController(),
      countyCrtl = TextEditingController(),
      stateCrtl = TextEditingController();

  Future<void> saveDataToHive(List<Data> dataList) async {
    final box = await Hive.openBox<Data>('dataCustBox');
    await box.clear();

    for (var data in dataList) {
      await box.add(data);
    }
  }

  Future<void> getCustomerList() async {
    try {
      final box = await Hive.openBox<Data>('dataCustBox');
      if (box.isNotEmpty && _connectionStatus == ConnectivityResult.none) {
        final dataList = List<Data>.from(box.values);
        emit(CustomersDataLoaded(data: dataList));
        return;
      }
      debugPrint("sdfdf");
      final response = await Api.call(context,
          endPoint: listCustomerUrl, method: Method.get);

      if (response.data is List) {
        final dataList =
            List<Data>.from(response.data.map((item) => Data.fromJson(item)));
        await saveDataToHive(dataList);
        emit(CustomersDataLoaded(data: dataList));
      } else {
        debugPrint("Invalid response format");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  searchCustomer() async {
    final response = await Api.call(context,
        endPoint: "$searchCustomUrl${searchCtrl.text}", method: Method.get);
    if (response.data is List) {
      final dataList =
          List<Data>.from(response.data.map((item) => Data.fromJson(item)));
      emit(CustomersDataLoaded(data: dataList));
    } else {
      debugPrint("Invalid response format");
    }
  }

  emailValidator(String companyMail) {
    if (companyMail.isEmpty) return 'Enter email';

    final isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(companyMail);
    if (!isValidEmail) {
      return 'Enter valid email';
    }

    return null;
  }

  addNewCustomer() async {
    if (step1FormKey.currentState?.validate() == false) return;
    final body = {
      "name": customerNameCtrl.text,
      "profile_pic": "",
      "mobile_number": numberCtrl.text,
      "email": emailCtrl.text,
      "street": streetCtrl.text,
      "street_two": street2Crtl.text,
      "city": cityCrtl.text,
      "pincode": int.parse(pinCodeCrtl.text),
      "country": countyCrtl.text,
      "state": stateCrtl.text
    };
    final response = await Api.call(context,
        endPoint: "$listCustomerUrl/", method: Method.post, body: body);

    if (response.status) {
      snackBar(context, message: response.message, type: MessageType.success);
      getCustomerList();
      customerNameCtrl.text = "";
      emailCtrl.text = "";
      street2Crtl.text = "";
      streetCtrl.text = "";
      pinCodeCrtl.text = "";
      countyCrtl.text = "";
      stateCrtl.text = "";
      Screen.closeDialog(context);
    } else {
      snackBar(context, message: response.message, type: MessageType.error);
    }
  }

  updateCustomerValues({Data? details}) {
    customerNameCtrl.text = details?.name ?? "";
    numberCtrl.text = details?.mobileNumber ?? "";
    emailCtrl.text = details?.email ?? "";
    streetCtrl.text = details?.street ?? "";
    street2Crtl.text = details?.streetTwo ?? "";
    cityCrtl.text = details?.city ?? "";
    pinCodeCrtl.text = details?.pincode.toString() ?? "";
    countyCrtl.text = details?.country ?? "";
    stateCrtl.text = details?.state ?? "";
  }

  updateCustomervalEmpty() {
    customerNameCtrl.text = "";
    numberCtrl.text = "";
    emailCtrl.text = "";
    streetCtrl.text = "";
    street2Crtl.text = "";
    cityCrtl.text = "";
    pinCodeCrtl.text = "";
    countyCrtl.text = "";
    stateCrtl.text = "";
  }

  updateCustomer(Data? details) async {
    final body = {
      "name": customerNameCtrl.text,
      "profile_pic": details?.profilePic ?? "",
      "mobile_number": numberCtrl.text,
      "email": emailCtrl.text,
      "street": streetCtrl.text,
      "street_two": street2Crtl.text,
      "city": cityCrtl.text,
      "pincode": int.parse(pinCodeCrtl.text),
      "country": countyCrtl.text,
      "state": stateCrtl.text
    };
    final response = await Api.call(context,
        endPoint: "$listCustomerUrl/?id=${details?.id}",
        method: Method.put,
        body: body);
    if (response.status) {
      getCustomerList();
      customerNameCtrl.text = "";
      emailCtrl.text = "";
      street2Crtl.text = "";
      streetCtrl.text = "";
      pinCodeCrtl.text = "";
      countyCrtl.text = "";
      stateCrtl.text = "";
      Screen.closeDialog(context);
      snackBar(context, message: response.message, type: MessageType.success);
    } else {
      snackBar(context, message: response.message, type: MessageType.error);
    }
  }
}
