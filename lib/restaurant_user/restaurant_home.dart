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

              SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Themes.color,
                    onPressed: () {
                      Map<String, dynamic> itemData = {
                        'foodName': this.foodName,
                        'price': this.amount,
                        'imageUrl': this.imageUrl,
                      };
                       /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuTile(rest_user: widget.rest_user))
                      );*/
                    },
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.yellow,
                    child: Text(
                      'Show Menu',
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                    ),
                  ),
                  SizedBox(height:20),
                  //Column()
                  //mainAxisAlignment: MainAxisAlignment.start,
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
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                    ),
                  ),
                   SizedBox(height:20),
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
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                    ),
                  ),
                  SizedBox(height:20),
                  //mainAxisAlignment: MainAxisAlignment.end,
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
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
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

/*class MenuTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: () {Navigator.pop(context);}),
        title: const Text("Today's Menu"),
      ),
      body: Container(
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
                    'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcache.marriott.com%2Fmarriottassets%2Fmarriott%2FBOMSA%2Fbomsa-exterior-0023-hor-feat.jpg%3Foutput-quality%3D70%26interpolation%3Dprogressive-bilinear%26downsize%3D1180px%3A*&imgrefurl=https%3A%2F%2Fwww.marriott.com%2Fhotels%2Ftravel%2Fbomsa-jw-marriott-mumbai-sahar%2F&tbnid=FjAF4zstZ1ROqM&vet=12ahUKEwiJr8P-jaDuAhXQFnIKHeU9APQQMygAegUIARDRAQ..i&docid=4NUVthfgmv15fM&w=1180&h=472&q=hotel%20photo&ved=2ahUKEwiJr8P-jaDuAhXQFnIKHeU9APQQMygAegUIARDRAQ',
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
*/
