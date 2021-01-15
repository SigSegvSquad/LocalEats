import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localeat/miscellaneous/theme_color.dart';
import 'package:localeat/user_management/restaurant_management.dart';
import 'addPage.dart';
import 'deletePage.dart';
class RestaurantHome extends StatefulWidget {
  final FirebaseUser rest_user;

  // receive data from the FirstScreen as a parameter
  RestaurantHome({Key key, @required this.rest_user}) : super(key: key);

  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  String restaurantName;
  String foodName;
  String amount;
  String restaurantEmail;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    Firestore.instance
        .collection('Restaurant')
        .document(widget.rest_user.uid)
        .get()
        .then((querySnapshot) {
      Firestore.instance
          .collection('Restaurant')
          .document(widget.rest_user.uid)
          .get()
          .then((querySnapshot) {
        var menu = querySnapshot.data['menu'];
        menu.forEach((key, map) {
          print(map['name']);
          print(map['price']);
        });
      });
    });
    RestaurantManagement restaurant_management = new RestaurantManagement();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 70.0),
              Container(
                color: Colors.white10,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Restaurant',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 45),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Themes.color,
                    onPressed: () {
                      Map<String, dynamic> itemData = {
                        'foodName': this.foodName,
                        'price': this.amount,
                        'imageUrl': this.imageUrl,
                      };
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => addPage(rest_user: widget.rest_user)));
                      restaurant_management
                          .addData(itemData, widget.rest_user)
                          .then((result) {
                        dialogTrigger(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.yellow,
                    child: Text(
                      'Add Item',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton(
                    color: Themes.color,
                    onPressed: () {
                      Map<String, dynamic> itemData = {
                        'foodName': this.foodName,
                        'price': this.amount,
                        'imageUrl': this.imageUrl,
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => deletePage(rest_user: widget.rest_user))
                      );
                      /*restaurant_management
                          .deleteData(itemData, widget.rest_user)
                          .then((result) {
                        dialogTrigger(context);
                      }).catchError((e) {
                        //print(e);
                      });*/
                    },
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.yellow,
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.red.shade400,
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context)
                            .pushReplacementNamed('\firstpage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.yellow,
                    child: Text(
                      'LogOut',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> dialogTrigger(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Job done', style: TextStyle(fontSize: 22.0)),
          //content: Text(
            //'Added Successfully',
            //style: TextStyle(fontSize: 20.0),
          //),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Work Now',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Themes.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}