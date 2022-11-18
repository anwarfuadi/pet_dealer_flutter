import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.currency(symbol: "Rp ", decimalDigits: 0);
    var prefixHero = "productList";
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: product, prefixHero: prefixHero)
        );
      }),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Hero(
                  tag: "${prefixHero}-${product.id}",
                  child: Image.network("${ENDPOINTAPI}/storage/${product.images[0]}"),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: numberFormat.format(product.price),
                  style: TextStyle(
                      fontSize: 18, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: "",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
