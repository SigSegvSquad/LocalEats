import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  String title;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    @required this.title,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    print(title);
    this.quantity++;
    print(quantity);
  }

  void decrementQuantity() {
    this.quantity--;
  }
}
