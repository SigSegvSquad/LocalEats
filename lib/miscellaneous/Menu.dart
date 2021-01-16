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
        leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () {Navigator.pop(context);}),
        title: const Text("Today's Menu"),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color:Colors.white,
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image.network(
                    restaurant.uri,
                    fit: BoxFit.fitWidth,
                    height: 200 ,
                  ),
                ),// List(),
              ],
            )
        ),
      ),
    );
  }
}