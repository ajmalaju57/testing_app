import 'package:hive/hive.dart';
part 'cart_items_model.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double price;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  String customerName;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.customerName,
  });
}