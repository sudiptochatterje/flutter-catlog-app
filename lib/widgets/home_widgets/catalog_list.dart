import 'package:flutter/material.dart';
import 'package:flutter_application_one/pages/home_detail_page.dart';
import 'package:flutter_application_one/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/catalog.dart';
import 'catalog_item.dart';

class CatlogList extends StatelessWidget {
  const CatlogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: CatlogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatlogModel.items[index];
              return InkWell(
                  onTap: () =>
                      // Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => HomeDetail(catalog: catalog),
                      //       ),
                      //     ),
                      context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeDetailRoute,
                              queryParameters: {"id": catalog.id.toString()}),
                          params: catalog),
                  child: CatalogItem(catlog: catalog));
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatlogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatlogModel.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDetail(catalog: catalog),
                        ),
                      ),
                  child: CatalogItem(catlog: catalog));
            },
          );
  }
}
