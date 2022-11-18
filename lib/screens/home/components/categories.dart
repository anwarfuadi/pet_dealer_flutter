import 'package:flutter/material.dart';
import 'package:shop_app/models/Category.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'dart:convert' as convert;

import '../../../size_config.dart';
import '../../../constants.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> listCategories;

  @override
  void initState() {
    listCategories = _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(10),
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20)
      ),
      child: FutureBuilder<List<Category>>(
        future: listCategories,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return LinearProgressIndicator();
          }else{
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  snapshot.data.length,
                  (index) => CategoryCard(
                    icon: "${ENDPOINTAPI}/storage/${snapshot.data[index].image_path}",
                    text: snapshot.data[index].name,
                    press: () {
                      ProductListArgument args = ProductListArgument(
                        title: snapshot.data[index].name,
                        category_id: snapshot.data[index].id
                      );
                      Navigator.pushNamed(context, CartScreen.routeName, arguments: args);
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  
  Future<List<Category>> _getCategories() async {

    Map<String, String>? reqHeaders = {
      "ngrok-skip-browser-warning":"1"
    };

    final response = await http.get(Uri.parse('${ENDPOINTAPI}/api/category'),headers: reqHeaders);
    final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final items = jsonResponse["data"].cast<Map<dynamic, dynamic>>();
    List<Category> cats = items.map<Category>((json){
      return Category.fromJson(json);
    }).toList();
    return cats;
    
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(70),
        child: Column(
          children: [
            Container(
              height: getProportionateScreenWidth(80),
              width: getProportionateScreenWidth(80),
              child: Image.network(icon!),
            ),
            SizedBox(height: 1),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
