import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(children: [
        _CartList().p32().expand(),
        Divider(),
        _CartTotal(),
      ]),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VxConsumer(
              mutations: {RemoveMutation},
              builder: (BuildContext context, store, VxStatus? status) {
                return "\$${_cart.totalPrice}"
                    .text
                    .xl5
                    .color(context.accentColor)
                    .make();
              },
            ),
            30.widthBox,
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: "Not Supported Yet".text.make()));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(context.theme.buttonColor)),
              child: "Buy".text.white.make(),
            ).w32(context)
          ],
        ));
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);

    final CartModel _cart = (VxState.store as MyStore).cart;

    return _cart.items.isEmpty
        ? "Nothing to show.".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.done),
              trailing: IconButton(
                icon: Icon(
                  (Icons.remove_circle_outline),
                ),
                onPressed: () {
                  RemoveMutation(_cart.items[index]);
                },
              ),
              title: _cart.items[index].name.text.make(),
            ),
          );
  }
}
