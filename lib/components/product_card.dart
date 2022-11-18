import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import '../constants.dart';
import '../size_config.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.prefixHero
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final String prefixHero;

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('#,###,000');
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product, prefixHero: prefixHero),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: "${prefixHero}-${product.id}",
                    child: Image.network("${ENDPOINTAPI}/storage/${product.images[0]}"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${numberFormat.format(product.price)}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
