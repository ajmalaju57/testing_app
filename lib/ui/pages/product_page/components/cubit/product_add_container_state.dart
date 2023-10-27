// ignore_for_file: must_be_immutable

part of 'product_add_container_cubit.dart';

@immutable
sealed class ProductAddContainerState {}

final class ProductAddContainerInitial extends ProductAddContainerState {}

class AddToCartDataLoaded extends ProductAddContainerState {
  List<CartItem> box;
  String? totalTaxPrice;
  String? totalPrice;
  AddToCartDataLoaded({required this.box, this.totalTaxPrice,this.totalPrice});
}
