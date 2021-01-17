import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localeat/miscellaneous/globals.dart' as globals;

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
        backgroundColor: Colors.amber,
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

          AwesomeButton()

        ],
      ),
    ));
  }
}

class AwesomeButton extends StatefulWidget {
  @override
  AwesomeButtonState createState() => new AwesomeButtonState();
}

class AwesomeButtonState extends State<AwesomeButton> {
  int counter = 0;
  @override
  Widget build(BuildContext context){
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
                            setState(() {
                              if (counter > 0) (
                                  // ignore: unnecessary_statements
                                  counter--
                              );
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