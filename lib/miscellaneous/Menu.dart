import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:localeat/miscellaneous/cart_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:localeat/miscellaneous/globals.dart' as globals;
import 'package:localeat/order_management/food_item_template.dart';

class Menu extends StatelessWidget {
  globals.Restaurant restaurant;

  Menu(var restaurant){
    globals.menuList.clear();
    this.restaurant = restaurant;
    this.restaurant.menu.forEach((key, value) {
      globals.menuList.add(globals.MenuItem(name: value['name'], uri: value['image_uri'], price: value['price']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: globals.accent_color,
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("Today's Menu"),
      ),
      body: ListView(
        children: [
          ClipRRect(
            child: Image.network(
              restaurant.uri,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          for(var menuItem in globals.menuList)
            Builder(
              builder: (context) {
                print(menuItem);
                return MenuTile(name: menuItem.name, price: menuItem.price, uri: menuItem.uri,);
              },
            )
        ],
      )
    );
  }
}

class MenuTile extends StatelessWidget {
  final String name, price, uri;

  MenuTile({
    @required this.name, @required this.price, @required this.uri
  });

  @override
  Widget build(BuildContext context) {
    var item = FoodItem(title: name, price: double.parse(price), imgUrl: uri);
    return GestureDetector(
        child: Container(
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
          SizedBox(
            width: 200,
            child: Column(
              children: [Align(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),

                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Lobster',
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: Colors.black),
                      ))),
                Align(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: Text(
                          '₹ '+price, textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: Colors.black),
                        )))],
            ),
          ),

          AwesomeButton(item)

        ],
      ),
    ));
  }
}

class AwesomeButton extends StatefulWidget {
  FoodItem item;

  AwesomeButton(this.item);


  @override
  AwesomeButtonState createState() => new AwesomeButtonState();
}

class AwesomeButtonState extends State<AwesomeButton> {
  int counter = 0;
  @override
  Widget build(BuildContext context){
    var item = widget.item;
    CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    addToCart(FoodItem foodItem) {
      bloc.addToList(foodItem);
    }

    removeFromList(FoodItem foodItem) {
      bloc.removeFromList(foodItem);
    }
    return  new Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 50.0,
                      child: new RaisedButton(child: new Text("-", style: new TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 30.0)),shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: Colors.red)
                      ),
                          onPressed: () {
                            removeFromList(item);
                            final snackBar = SnackBar(
                              content: Text('₹${item.title} removed from Cart'),
                              duration: Duration(milliseconds: 550),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              if(counter>0){
                                counter--;
                              }
                            });
                          }
                      )
                    ),

                    new Text('   $counter', style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    new Padding(padding: new EdgeInsets.all(15.0)),
                    new SizedBox(
                      width: 50.0,
                        child: new RaisedButton(
                            child: new Text("+", style: new TextStyle(color: Colors.black, fontStyle: FontStyle.normal, fontSize: 30.0)),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: Colors.red)
                        ),
                            onPressed: (){
                              addToCart(item);
                              final snackBar = SnackBar(
                                content: Text('₹${item.title} added to Cart'),
                                duration: Duration(milliseconds: 550),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                counter++;
                              });
                            }
                        ),
                    ),


                  ],
                )
            );

      }
}