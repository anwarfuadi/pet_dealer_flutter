import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../size_config.dart';
import 'cart_card.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  String? term;
  int? category_id;

  Body({this.term, this.category_id});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Product>> listProduct;

  @override
  void initState() {
    listProduct = _getListProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder(
        future: listProduct,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return LinearProgressIndicator();
          }else if(snapshot.data.length == 0){
            return Container(child: Text("Produk tidak ditemukan"), alignment: Alignment.topCenter);
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CartCard(product: snapshot.data[index]),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<Product>> _getListProduct() async {
    var url;
    if(widget.category_id != null){
      url = "${ENDPOINTAPI}/api/product/category/${widget.category_id}";
    }else{
      url = "${ENDPOINTAPI}/api/product/search/${widget.term}";
    }
    final response = await http.get(Uri.parse(url));
    final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final items = jsonResponse["data"].cast<Map<dynamic, dynamic>>();
    List<Product> products = items.map<Product>((json){
      return Product.fromJson(json);
    }).toList();
    return products;
  }
}
