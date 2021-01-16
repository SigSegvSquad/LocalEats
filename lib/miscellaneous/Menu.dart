import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localeat/miscellaneous/globals.dart' as globals;

class MenuTile extends StatelessWidget {
  final globals.Restaurant restaurant;

  MenuTile({
    @required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("Today's Menu"),
      ),
      body: Center(
        child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  child: Image.network(
                    restaurant.uri,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                MenuList(),
              ],
            )),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Firestore.instance
        .collection('Restaurant')
        .document('q82S4DFACWUDXNwoJmYP9eYgqwl2')
        .get()
        .then((querySnapshot) {
      Firestore.instance
          .collection('Restaurant')
          .document('q82S4DFACWUDXNwoJmYP9eYgqwl2')
          .get()
          .then((querySnapshot) {
        var menu = querySnapshot.data['menu'];
        menu.forEach((key, map) {
          Menu(name: menu['name'], price: menu['price']);
        });
      });
    });
    return Container();
  }
}

class Menu extends StatelessWidget {
  final String name, price;

  Menu({
    @required this.name,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Align(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Lobster',
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ))),
          Align(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: Text(
                    price,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black),
                  )))
        ],
      ),
    );
  }
}
