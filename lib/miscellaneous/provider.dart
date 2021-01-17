import 'package:localeat/order_management/food_item_template.dart';

class CartProvider {
  //couterProvider only consists of a counter and a method which is responsible for increasing the value of count
  List<FoodItem> foodItems = [];

  List<FoodItem> addToList(FoodItem foodItem) {
    bool isPresent = false;

    if (foodItems.length > 0) {
      for (int i = 0; i < foodItems.length; i++) {
        print(foodItems[i].title);
        print(foodItem.title);
        if (foodItems[i].title == foodItem.title) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }

    return foodItems;
  }

  List<FoodItem> removeFromList(FoodItem foodItem) {
    if (foodItem.quantity > 1) {
      //only decrease the quantity
      decreaseItemQuantity(foodItem);
    } else {
      //remove it from the list
      foodItems.remove(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodItem foodItem) => foodItem.incrementQuantity();

  void decreaseItemQuantity(FoodItem foodItem) => foodItem.decrementQuantity();
}
