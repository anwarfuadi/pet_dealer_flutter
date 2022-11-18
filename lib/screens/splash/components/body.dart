import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _username;
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Selamat Datang di Toko Ikan Hias!",
      "image": "assets/images/ikanhias.png"
    },
    // {
    //   "text":
    //       "We help people conect with store \naround United State of America",
    //   "image": "assets/images/splash_2.png"
    // },
    // {
    //   "text": "We show the easy way to shop. \nJust stay at home with us",
    //   "image": "assets/images/splash_3.png"
    // },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Lanjutkan",
                      press: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        _username = prefs.getString("email") ?? "";
                        if(_username == ""){
                          Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, ModalRoute.withName(SignInScreen.routeName));
                        }else{
                          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, ModalRoute.withName(HomeScreen.routeName));
                        }
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
  
  _loadUserInfo() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _username = prefs.getString("email") ?? "";
    // if(_username == ""){
    //   Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, ModalRoute.withName(SignInScreen.routeName));
    // }else{
    //   Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, ModalRoute.withName(HomeScreen.routeName));
    // }
  }
}
