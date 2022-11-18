import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String term = "";

    return Container(
      width: SizeConfig.screenWidth * 0.75,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value){
          term = value;
          print(term);
        },
        onEditingComplete: (){
          ProductListArgument args = ProductListArgument(title: term);
          Navigator.pushNamed(context, CartScreen.routeName, arguments: args);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Cari...",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
