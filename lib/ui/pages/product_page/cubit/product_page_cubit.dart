// ignore_for_file: depend_on_referenced_packages, unnecessary_import, use_build_context_synchronously, unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:test_eco/data/models/products_list_model.dart';
import 'package:test_eco/data/services/api.dart';
import 'package:test_eco/data/services/urls.dart';
import 'package:test_eco/utils/shared/app_snackbar.dart';

part 'product_page_state.dart';

class ProductPageCubit extends Cubit<ProductPageState> {
  ProductPageCubit(this.context) : super(ProductPageInitial()) {
    init();
  }

  init() async {
    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getProductList();
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
  TextEditingController searchCtrl = TextEditingController();

  Future<void> saveDataToHive(List<Data> dataList) async {
    final box = await Hive.openBox<Data>('dataBox');
    await box.clear();

    for (var data in dataList) {
      await box.add(data);
    }
  }

  Future<void> getProductList() async {
    try {
      final box = await Hive.openBox<Data>('dataBox');
      if (box.isNotEmpty && _connectionStatus == ConnectivityResult.none) {
        final dataList = List<Data>.from(box.values);
        emit(ProductDataLoaded(data: dataList));
        return;
      }

      debugPrint("sdfdf");
      final response =
          await Api.call(context, endPoint: productListUrl, method: Method.get);

      if (response.data is List) {
        final dataList =
            List<Data>.from(response.data.map((item) => Data.fromJson(item)));

        await saveDataToHive(dataList);

        emit(ProductDataLoaded(data: dataList));
      } else {
        debugPrint("Invalid response format");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  searchProduct() async {
    final response = await Api.call(context,
        endPoint: "$searchProdUrl${searchCtrl.text}", method: Method.get);
    if (response.data is List) {
      final dataList =
          List<Data>.from(response.data.map((item) => Data.fromJson(item)));

      await saveDataToHive(dataList);

      emit(ProductDataLoaded(data: dataList));
    } else {
      debugPrint("Invalid response format");
    }
  }
}
