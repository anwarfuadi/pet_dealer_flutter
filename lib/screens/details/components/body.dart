import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/webview/webview_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final String prefixHero;

  const Body({Key? key, required this.product, required this.prefixHero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product, prefixHero: prefixHero,),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Hubungi Kami",
                          press: () {
                            //var url = "https://wa.me/${WANUMBER}?text=Tanya ini ${ENDPOINTAPI}/storage/${product.images[0]}";
                            //var uri = Uri.parse(url);
                            //Navigator.pushNamed(context, WebViewScreen.routeName, arguments: url);

                            _launchWhatsapp(context, product);

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _launchWhatsapp(context, product) async {
      var whatsappAndroid = Uri.parse("whatsapp://send?phone=${WANUMBER}&text=${ENDPOINTAPI}/storage/${product.images[0]}");
      await launchUrl(whatsappAndroid);
      // if (await canLaunchUrl(whatsappAndroid)) {
      //     await launchUrl(whatsappAndroid);
      // } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("WhatsApp is not installed on the device"),
      //     ),
      //   );
      // }
  }
}
