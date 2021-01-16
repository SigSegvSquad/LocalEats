library localeat_spare.globals;

class Restaurant{
  String name;
  String uri;
  String uid;
  String location;
  var menu;

  Restaurant({this.name,this.uri,this.uid, this.location, this.menu});
}

class MenuItem{
  String name;
  String uri;
  String price;

  MenuItem({this.name, this.price, this.uri});
}

List<Restaurant> restaurantList = [];
List<MenuItem> menuList = [];