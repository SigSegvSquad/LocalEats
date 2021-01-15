import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localeat/restaurant_user/restaurant_home.dart';

class RestaurantManagement {
  storeNewRestaurant(user, name, context) {
    Firestore.instance.collection('Restaurant').document(user.uid).setData(
        {'email': user.email, 'name': name, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RestaurantHome(rest_user: user)));
    }).catchError((e) {
      print(e);
    });
  }

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(restaurantData, restUser) async {
    var foodName = restaurantData['foodName'];
    var price = restaurantData['price'];
    var imageUrl = restaurantData['imageUrl'];
    if (isLoggedIn()) {
      Firestore.instance
          .collection('Restaurant')
          .document(restUser.uid)
          .updateData({
        "menu.${foodName}.image_url": imageUrl,
        "menu.${foodName}.name": foodName,
        "menu.${foodName}.price": price,
      }).catchError((e) {
        print(e);
      });
    } else {
      print('You need to logged in');
    }
  }
}
