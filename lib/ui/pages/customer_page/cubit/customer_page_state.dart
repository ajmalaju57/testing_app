part of 'customer_page_cubit.dart';

class CustomerPageState {}

final class CustomerPageInitial extends CustomerPageState {}

class CustomersDataLoaded extends CustomerPageState {
  List<Data>? data;
  CustomersDataLoaded({required this.data});
}
