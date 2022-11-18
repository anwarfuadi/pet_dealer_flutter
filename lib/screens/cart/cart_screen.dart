import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final ProductListArgument args =
        ModalRoute.of(context)!.settings.arguments as ProductListArgument;

    return Scaffold(
      appBar: buildAppBar(context, args.title),
      body: Body(category_id: args.category_id,term: args.title),
      //bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          // Text(
          //   "${demoCarts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}

class ProductListArgument{
  String title;
  int? category_id;

  ProductListArgument({required this.title, this.category_id});
}


