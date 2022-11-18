import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../size_config.dart';
import '../../../constants.dart';
import 'section_title.dart';

class NewProducts extends StatefulWidget {
  @override
  State<NewProducts> createState() => _NewProductsState();
}

class _NewProductsState extends State<NewProducts> {
  late Future<List<Product>> listProduct;

  @override
  void initState() {
    listProduct = _getListProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Ikan Terbaru", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        FutureBuilder(
          future: listProduct,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return LinearProgressIndicator();
            }else{
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      snapshot.data.length,
                      (index) {
                        return ProductCard(product: snapshot.data[index], prefixHero: "new",);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              );
            }

          }
        ),
        
      ],
    );
  }
  
  Future<List<Product>> _getListProduct() async {
    Map<String, String>? reqHeaders = {
      "ngrok-skip-browser-warning":"1"
    };

    final response = await http.get(Uri.parse('${ENDPOINTAPI}/api/product/new'),headers: reqHeaders);
    final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final items = jsonResponse["data"].cast<Map<dynamic, dynamic>>();
    List<Product> products = items.map<Product>((json){
      return Product.fromJson(json);
    }).toList();
    return products;
  }
}
