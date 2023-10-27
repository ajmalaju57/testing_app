// ignore_for_file: must_be_immutable

part of 'product_page_cubit.dart';

@immutable
sealed class ProductPageState {}

final class ProductPageInitial extends ProductPageState {}

class ProductDataLoaded extends ProductPageState {
  List<Data>? data;
  ProductDataLoaded({required this.data});
}
