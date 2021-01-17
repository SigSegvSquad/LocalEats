import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localeat/miscellaneous/globals.dart' as globals;
import 'package:localeat/order_management/end_order.dart';
import 'package:localeat/order_management/debit_card.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 10, 15),
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.back,
                        size: 45,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Payment Option',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  color: globals.accent_color,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: globals.accent_color)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.local_atm,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Cash On Delivery',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Location()));
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: globals.accent_color,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2, color: globals.accent_color)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.amazonPay,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Debit/Credit card',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => CreditCardPage()));
                  },
                ),
              ),
            ),
            SizedBox(height: 150),
            SizedBox(
              height:MediaQuery.of(context).size.height * 0.4,
            child:Container(
                child:FlutterMap(
                  options: new MapOptions(
                    center: new latLng.LatLng(18.464285, 73.8677875),
                    zoom: 16.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 40.0,
                          height: 40.0,
                          point: new latLng.LatLng(18.4640767, 73.8676183),
                          builder: (ctx) => new Container(
                              child: Image(image:NetworkImage('https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678111-map-marker-512.png'))
                          ),
                        ),
                      ],
                    ),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 40.0,
                          height: 40.0,
                          point: new latLng.LatLng(18.4644933, 73.8679567),
                          builder: (ctx) => new Container(
                            child: Image(image:NetworkImage('http://www.pngall.com/wp-content/uploads/2017/05/Map-Marker-PNG-Pic.png')),
                          ),
                        ),
                      ],
                    ),

                  ],
                )
            ),
            )
          ],
        ),
      ),
    );
  }
}
