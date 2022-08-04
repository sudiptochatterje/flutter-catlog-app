import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_one/core/store.dart';
import 'package:flutter_application_one/models/cart.dart';
import 'package:flutter_application_one/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_application_one/models/catalog.dart';

import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson = await rootBundle.loadString("assets/files/catlog.json");
    // final response = await http.get(Uri.parse(url));
    // final catalogJson = response.body;
    var decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatlogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (BuildContext context, store, VxStatus? status) {
            return FloatingActionButton(
              onPressed: () {
                context.vxNav.push(Uri.parse(MyRoutes.cartRoute));
              },
              backgroundColor: context.theme.buttonColor,
              child: Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ).badge(
                color: Vx.red500,
                size: 22,
                count: _cart.items.length,
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold));
          }),
      body: SafeArea(
        child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatlogModel.items != null && CatlogModel.items.isNotEmpty)
                  CatlogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            )),
      ),
    );
  }
}
