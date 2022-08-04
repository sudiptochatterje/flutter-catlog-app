import 'package:flutter_application_one/core/store.dart';
import 'package:flutter_application_one/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  late CatlogModel _catalog;

  final List<int> _itemIds = [];

  CatlogModel get catalog => _catalog;

  set catalog(CatlogModel newCatlog) {
    assert(newCatlog != null);
    _catalog = newCatlog;
  }

  //get items in cart
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //add item
  void add(Item item) {
    _itemIds.add(item.id);
  }
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    store?.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);

  @override
  perform() {
    store?.cart._itemIds.remove(item.id);
  }
}
