import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_application_one/models/cart.dart';

import '../models/catalog.dart';

class MyStore extends VxStore {
  late CatlogModel catalog;
  late CartModel cart;

  MyStore() {
    catalog = CatlogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}
